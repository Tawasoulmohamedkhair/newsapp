import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/profile/data/models/profile_model.dart';
import 'package:newsapp/features/profile/domain/entities/profile_entity.dart';
import 'package:newsapp/features/profile/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseClient supabase;
  final SharedPreferences
  prefs; 

  ProfileRepositoryImpl({required this.supabase, required this.prefs});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return const Left(ServerFailure("User not authenticated"));
      }
            final model = ProfileModel(
        id: user.id,
        name:
            prefs.getString('username') ??
            user.userMetadata?['username'] ??
            user.userMetadata?['name'] ??
            user.email?.split('@')[0] ??
            'User',
        email: user.email,
        phone:
            prefs.getString('user_phone') ??
            user.userMetadata?['phone_number'] ??
            '',
        imagePath: prefs.getString('user_image'),
      );

      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    String? phone,
  }) async {
    try {
      
      await prefs.setString('username', name);
      if (phone != null && phone.isNotEmpty) {
        await prefs.setString('user_phone', phone);
      }

      
      final Map<String, dynamic> updatedMetadata = {'username': name};

      if (phone != null) {
        updatedMetadata['phone_number'] = phone;
      }

      await supabase.auth.updateUser(UserAttributes(data: updatedMetadata));

      return await getProfile();
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(String imagePath) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final bytes = await File(imagePath).readAsBytes();

      await supabase.storage
          .from('avatars')
          .uploadBinary(fileName, bytes);

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

      // حفظ الرابط محلياً
      final prefs = getIt<SharedPreferences>();
      await prefs.setString('user_image', publicUrl);

      return Right(publicUrl);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      
      await supabase.auth.signOut();
      await prefs.remove('username');
      await prefs.remove('user_phone');
      await prefs.remove('user_image');

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
