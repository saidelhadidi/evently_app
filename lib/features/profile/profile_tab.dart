import 'dart:io';
import 'package:evently_app/core/remote/local/shared_prefs_helper.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/profile/widgets/change_language_option.dart';
import 'package:evently_app/features/profile/widgets/dark_switcher.dart';
import 'package:evently_app/features/profile/widgets/profile_menu_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? _imagePath;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    if (user?.email != null) {
      String? fileName =
          await SharedPrefsHelper.getProfileImageName(user!.email!);
      if (fileName != null) {
        final directory = await getApplicationDocumentsDirectory();
        final path = p.join(directory.path, fileName);
        if (await File(path).exists() && mounted) {
          setState(() {
            _imagePath = path;
          });
        }
      }
    }
  }

  Future<void> _pickAndCropImage() async {
    final Color primaryColor = Theme.of(context).primaryColor;
    final ImagePicker picker = ImagePicker();

    final String? action = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Gallery'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            if (_imagePath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remove Photo',
                    style: TextStyle(color: Colors.red)),
                onTap: () => Navigator.pop(context, 'remove'),
              ),
          ],
        ),
      ),
    );

    if (!mounted || action == null) return;

    if (action == 'remove') {
      if (user?.email != null) {
        await SharedPrefsHelper.saveProfileImageName(user!.email!, "");
        setState(() {
          _imagePath = null;
        });
      }
      return;
    }

    final XFile? image = await picker.pickImage(
      source: action == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );

    if (!mounted || image == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (!mounted || croppedFile == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final String extension = p.extension(croppedFile.path);
    final String fileName = "profile_${user!.email}$extension";
    final String permanentPath = p.join(directory.path, fileName);

    await File(croppedFile.path).copy(permanentPath);
    await SharedPrefsHelper.saveProfileImageName(user!.email!, fileName);

    setState(() {
      _imagePath = permanentPath;
    });
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringsManager.logoutTitle),
        content: Text(StringsManager.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(StringsManager.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await FirebaseAuth.instance.signOut();
              await SharedPrefsHelper.saveLoginStatus(false);
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LogInScreen.routeName,
                  (route) => false,
                );
              }
            },
            child: Text(
              StringsManager.yes,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              GestureDetector(
                onTap: _pickAndCropImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      backgroundImage: _imagePath != null
                          ? FileImage(File(_imagePath!))
                          : null,
                      child: _imagePath == null
                          ? Icon(Icons.person,
                              size: 80, color: Theme.of(context).primaryColor)
                          : null,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
              Text(
                user?.displayName ?? "User Name",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                user?.email ?? "User Email",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const DarkSwitcher(),
              const ChangeLanguageOption(),
              ProfileMenuTile(
                onTap: _showLogoutConfirmation,
                title: StringsManager.logout,
                trailingWidget: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
