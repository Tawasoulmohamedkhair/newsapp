import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/profile/domain/entities/profile_entity.dart';
import 'package:newsapp/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String name,
    String? phone,
  }) async {
    return await repository.updateProfile(name: name, phone: phone);
  }
}
