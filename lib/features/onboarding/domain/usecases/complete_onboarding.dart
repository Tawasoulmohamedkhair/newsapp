import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboarding implements UseCase<void, NoParams> {
  final OnboardingRepository repository;

  const CompleteOnboarding(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.completeOnboarding();
  }
}
