import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    String? phone,
  });

  Future<Either<Failure, String>> uploadProfileImage(String imagePath);

  Future<Either<Failure, bool>> logout();
}
