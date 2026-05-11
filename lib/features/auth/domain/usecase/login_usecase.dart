import 'package:dartz/dartz.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/auth/domain/repository/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository, {required PreferencesManager prefs});

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}
