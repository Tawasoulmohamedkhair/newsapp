import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import '../entities/onboardingentity.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingEntity>>> getOnboardingData();


  Future<Either<Failure, Unit>> completeOnboarding();
}
