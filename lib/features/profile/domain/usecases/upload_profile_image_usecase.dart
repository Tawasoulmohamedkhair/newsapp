// lib/features/profile/domain/usecases/upload_profile_image_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/profile/domain/repositories/profile_repository.dart';

class UploadProfileImageUseCase {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<Either<Failure, String>> call(String imagePath) async {
    return await repository.uploadProfileImage(imagePath);
  }
}
