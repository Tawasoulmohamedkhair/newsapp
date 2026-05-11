// import 'package:dartz/dartz.dart';
// import 'package:newsapp/core/error/failure.dart';
// import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';

// abstract class OnboardingRepository {
  
//   List<OnboardingEntity> getOnboardingData();

//   Future<Either<Failure, bool>> isOnboardingCompleted();
//   Future<Either<Failure, void>> completeOnboarding();
// }

import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import '../entities/onboardingentity.dart';

abstract class OnboardingRepository {
  // لازم تكون Future و Either
  Future<Either<Failure, List<OnboardingEntity>>> getOnboardingData();

  Future<Either<Failure, bool>> isOnboardingCompleted();

  // استبدلي void بـ Unit
  Future<Either<Failure, Unit>> completeOnboarding();
}
