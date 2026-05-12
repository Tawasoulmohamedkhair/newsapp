import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/services/auth_service.dart';
import 'package:newsapp/features/auth/domain/entities/user_entity.dart';
import 'package:newsapp/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // مهم جداً

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<Either<Failure, UserEntity>> register(
    String email,
    String password,
  ) async {
    try {
      // w
      final errorMessage = await authService.register(email, password);

      if (errorMessage != null) {
        return Left(ServerFailure(errorMessage));
      }

      final currentUser = Supabase.instance.client.auth.currentUser;

      if (currentUser == null) {
        return const Left(
          ServerFailure("An error occurred while fetching user data."),
        );
      }

      final userEntity = UserEntity(
        id: currentUser.id,
        email: currentUser.email ?? '',
      );

      return Right(userEntity);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final errorMessage = await authService.login(email, password);

      if (errorMessage != null) {
        return Left(ServerFailure(errorMessage));
      }

      final currentUser = Supabase.instance.client.auth.currentUser;

      if (currentUser == null) {
        return const Left(
          ServerFailure("An error occurred while fetching user data."),
        );
      }

      final userEntity = UserEntity(
        id: currentUser.id,
        email: currentUser.email ?? '',
      );

      return Right(userEntity);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await authService.logout();
  }
}
