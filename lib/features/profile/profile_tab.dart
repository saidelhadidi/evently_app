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
      String? savedPath =
          await SharedPrefsHelper.getProfileImagePath(user!.email!);
      if (savedPath != null && mounted) {
        setState(() {
          _imagePath = savedPath;
        });
      }
    }
  }

  Future<void> _pickAndCropImage() async {
    // 1. Capture primary color before any async gap to satisfy the linter
    final Color primaryColor = Theme.of(context).primaryColor;

    // 2. Show bottom sheet to choose action
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
        await SharedPrefsHelper.saveProfileImagePath(user!.email!, "");
        setState(() {
          _imagePath = null;
        });
      }
      return;
    }

    // 3. Pick the image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: action == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );

    if (!mounted || image == null) return;

    // 4. Crop the image
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

    // 5. Save and update state
    if (user?.email != null) {
      await SharedPrefsHelper.saveProfileImagePath(
          user!.email!, croppedFile.path);
      setState(() {
        _imagePath = croppedFile.path;
      });
    }
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
                      radius: 70,
                      backgroundColor:
                          Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      backgroundImage: _imagePath != null
                          ? FileImage(File(_imagePath!))
                          : null,
                      child: _imagePath == null
                          ? Icon(
                              Icons.person,
                              size: 80,
                              color: Theme.of(context).primaryColor,
                            )
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await SharedPrefsHelper.saveLoginStatus(false);
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LogInScreen.routeName,
                      (route) => false,
                    );
                  }
                },
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
