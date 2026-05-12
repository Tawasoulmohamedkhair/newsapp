import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
import 'package:newsapp/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<OnboardingEntity>>> getOnboardingData() async {
    try {
      final models = await localDataSource.getOnboardingPages();

      return Right(models);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> completeOnboarding() {
    throw UnimplementedError();
  }

  
}
