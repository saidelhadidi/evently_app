import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadProfileImage({
    required File imageFile,
    required String uid,
    required String userName,
  }) async {
    try {
      final String fileName = '$uid/$userName.$uid.png';
      await _supabase.storage.from('profiles').upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      // Get public URL
      final String publicUrl = _supabase.storage.from('profiles').getPublicUrl(fileName);
      
      return publicUrl;
    } catch (e) {
      debugPrint('❌ Error uploading image to Supabase: $e');
      return null;
    }}
  Future<void> deleteProfileImage(String uid) async {
    try {
      // List all files in the user's folder
      final List<FileObject> files = await _supabase.storage.from('profiles').list(path: uid);
      
      if (files.isNotEmpty) {
        final List<String> pathsToDelete = files.map((file) => '$uid/${file.name}').toList();
        await _supabase.storage.from('profiles').remove(pathsToDelete);
        debugPrint('✅ Profile images deleted from Supabase');
      }
    } catch (e) {
      debugPrint('❌ Error deleting images from Supabase: $e');
    }
  }
}
