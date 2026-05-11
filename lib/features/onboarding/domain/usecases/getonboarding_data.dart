// // features/onboarding/domain/usecases/get_onboarding_data.dart
// // import 'package:dartz/dartz.dart';
// // import 'package:newsapp/core/error/failure.dart';
// // import 'package:newsapp/core/usecases/usecase.dart';
// // import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';


// // class GetOnboardingData implements UseCase<List<OnboardingEntity>, NoParams> {
// //   @override
// //   Future<Either<Failure, List<OnboardingEntity>>> call(NoParams params) async {
// //     // في الواقع يمكن جلبها من repository، لكن هنا static
// //     final data = [
// //       const OnboardingEntity(
// //         image: 'assets/images/onboarding1.png',
// //         title: 'Trending News',
// //         description: 'Stay in the loop with the biggest breaking stories in a stunning visual slider. Just swipe to explore what’s trending right now!',
// //       ),
// //       const OnboardingEntity(
// //         image: 'assets/images/onboarding2.png',
// //         title: 'Pick What You Love',
// //         description: 'No more endless scrolling! Tap into your favorite topics like Tech, Politics, or Sports and get personalized news in seconds',
// //       ),
// //       const OnboardingEntity(
// //         image: 'assets/images/onboarding3.png',
// //         title: 'Save It. Read It Later. Stay Smart.',
// //         description: 'Found something interesting? Tap the bookmark and come back to it anytime. Never lose a great read again!',
// //       ),
// //     ];
// //     return Right(data);
// //   }
// // }

// // domain/usecases/get_onboarding_data.dart
// import 'package:dartz/dartz.dart';
// import 'package:newsapp/core/error/failure.dart';
// import 'package:newsapp/core/usecases/usecase.dart';
// import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
// import '../repositories/onboarding_repository.dart';

// class GetOnboardingData implements UseCase<List<OnboardingEntity>, NoParams> {
//   final OnboardingRepository repository;
//   GetOnboardingData(this.repository);

//   @override
//   Future<Either<Failure, List<OnboardingEntity>>> call(NoParams params) async {
//     // لو الداتا local ومش async
//     return  Right();
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/usecases/usecase.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingData implements UseCase<List<OnboardingEntity>, NoParams> {
  final OnboardingRepository repository;

  // حقنا الـ Repository
  GetOnboardingData(this.repository);

  @override
  Future<Either<Failure, List<OnboardingEntity>>> call(NoParams params) async {
    // الـ Repository مسؤول يرجع Either، فإحنا بنرجعه زي ما هو بالظبط
    return await repository.getOnboardingData();
  }
}
