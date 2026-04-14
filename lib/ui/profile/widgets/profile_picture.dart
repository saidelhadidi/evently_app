import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:evently_app/core/services/image_picker_service.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String? _localImagePath;
  StreamSubscription? _authSubscription;
  final ImagePickerService _imagePickerService = ImagePickerService();

  @override
  void initState() {
    super.initState();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null && _localImagePath == null) {
        _loadProfileImage();
      }
    });
    _loadProfileImage();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.uid != null) {
      final path = await _imagePickerService.getStoredProfileImage(user!.uid);
      if (path != null && mounted) {
        setState(() => _localImagePath = path);
      }
    }
  }

  Future<void> _onProfileTapped() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final homeProvider = context.read<HomeProvider>();
    final userData = homeProvider.currentUser;

    await _imagePickerService.showImagePickerOptions(
      context: context,
      uid: user.uid,
      hasImage: _localImagePath != null || (userData?.profilePic.isNotEmpty ?? false),
      onImageRemoved: () async {
        setState(() => _localImagePath = null);
        await homeProvider.deleteProfilePic();
      },
      onImagePicked: (File newFile) async {
        setState(() => _localImagePath = newFile.path);
        await homeProvider.uploadAndUpdateProfilePic(newFile);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final userData = homeProvider.currentUser;

    ImageProvider? imageProvider;
    if (_localImagePath != null) {
      imageProvider = FileImage(File(_localImagePath!));
    } else if (userData?.profilePic.isNotEmpty == true) {
      imageProvider = NetworkImage(userData!.profilePic);
    }

    return GestureDetector(
      onTap: _onProfileTapped,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            backgroundImage: imageProvider,
            child: imageProvider == null
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
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
