// core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {
  const NoParams();
}
