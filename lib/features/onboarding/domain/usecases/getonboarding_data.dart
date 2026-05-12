import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/usecases/usecase.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingData implements UseCase<List<OnboardingEntity>, NoParams> {
  final OnboardingRepository repository;

  GetOnboardingData(this.repository);

  @override
  Future<Either<Failure, List<OnboardingEntity>>> call(NoParams params) async {

    return await  repository.getOnboardingData();
  }
}
