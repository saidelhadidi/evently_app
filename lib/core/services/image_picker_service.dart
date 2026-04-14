import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../remote/local/shared_prefs_helper.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<void> showImagePickerOptions({
    required BuildContext context,
    required String uid,
    required bool hasImage,
    required Function() onImageRemoved,
    required Function(File file) onImagePicked,
  }) async {
    final Color primaryColor = Theme.of(context).primaryColor;

    final String? action = await showCupertinoModalPopup<String>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(ctx, 'gallery'),
            child: const Text('Photo Gallery'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(ctx, 'camera'),
            child: const Text('Camera'),
          ),
          if (hasImage)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(ctx, 'remove'),
              child: const Text('Remove Photo'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
      ),
    );

    if (action == null) return;

    if (action == 'remove') {
      await deleteStoredProfileImage(uid);
      onImageRemoved();
      return;
    }

    final File? pickedFile = await pickAndCropImage(
      source: action == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      toolbarColor: primaryColor,
    );

    if (pickedFile != null) {
      final File? savedFile = await saveProfileImageLocally(pickedFile, uid);
      if (savedFile != null) {
        onImagePicked(savedFile);
      }
    }
  }

  /// Picks and crops an image from the given source.
  Future<File?> pickAndCropImage({
    required ImageSource source,
    required Color toolbarColor,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;

      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: toolbarColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
            resetButtonHidden: false,
            aspectRatioPickerButtonHidden: true,
            doneButtonTitle: 'Done',
            cancelButtonTitle: 'Cancel',
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error in ImagePickerService: $e');
      return null;
    }
  }

  /// Saves the image to the application's permanent document directory.
  Future<File?> saveProfileImageLocally(File file, String uid) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String extension = p.extension(file.path);
      final String fileName = "profile_$uid$extension";
      final String permanentPath = p.join(directory.path, fileName);

      final File savedFile = await file.copy(permanentPath);
      await SharedPrefsHelper.saveProfileImageName(uid, fileName);
      return savedFile;
    } catch (e) {
      debugPrint('❌ Error saving image locally: $e');
      return null;
    }
  }

  /// Retrieves the absolute path of the stored profile image for a specific user.
  Future<String?> getStoredProfileImage(String uid) async {
    try {
      String? savedName = await SharedPrefsHelper.getProfileImageName(uid);
      if (savedName == null || savedName.isEmpty) return null;

      String fileName = p.basename(savedName);
      final directory = await getApplicationDocumentsDirectory();
      final path = p.join(directory.path, fileName);

      if (await File(path).exists()) {
        return path;
      }
    } catch (e) {
      debugPrint('❌ Error getting stored image: $e');
    }
    return null;
  }

  /// Removes the local reference to the profile image.
  Future<void> deleteStoredProfileImage(String uid) async {
    await SharedPrefsHelper.saveProfileImageName(uid, "");
  }
}
