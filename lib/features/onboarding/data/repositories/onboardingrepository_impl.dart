// import 'package:dartz/dartz.dart';
// import 'package:newsapp/core/error/failure.dart';
// import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
// import '../../domain/repositories/onboarding_repository.dart';
// import '../datasources/onboarding_local_datasource.dart';

// class OnboardingRepositoryImpl implements OnboardingRepository {
//   final OnboardingLocalDataSource localDataSource;

//   OnboardingRepositoryImpl(this.localDataSource);

//   @override
//   List<OnboardingEntity> getOnboardingData() {
//     // دي synchronous عشان الداتا static ومش بتضرب
//     return localDataSource.getOnboardingData();
//   }

//   @override
//   Future<Either<Failure, bool>> isOnboardingCompleted() async {
//     try {
//       final result = await localDataSource.isOnboardingCompleted();
//       return Right(result);
//     } catch (e) {
//       return const Left(CacheFailure('Failed to check onboarding status'));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> completeOnboarding() async {
//     try {
//       await localDataSource.setOnboardingCompleted();
//       return const Right(null);
//     } catch (e) {
//       return const Left(CacheFailure('Failed to complete onboarding'));
//     }
//   }
// }
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
      // 1. نادي الداتا سورس (اللي بترجع List<OnboardingModel>)
      final models = await localDataSource.getOnboardingPages();

      // 2. بما إن الـ OnboardingModel بيورث (extends) من الـ OnboardingEntity
      // الدارت هتعمل Upcast تلقائي ونقدر نرجعهم كـ Entity في الـ Right
      return Right(models);
    } catch (e) {
      // 3. لو حصل أي خطأ (مثلاً الـ assets ماحملتش)، هنا بنمسكه وبنحوله لـ Failure
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> completeOnboarding() {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() {
    throw UnimplementedError();
  }

  // ... باقي الدوال
}
