
import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/data/models/news_article_model.dart';
import 'package:newsapp/features/home/domain/repository/home_repository.dart';

class GetEverythingUseCase {
  final HomeRepository repository;

  GetEverythingUseCase(this.repository);

  Future<Either<Failure, List<NewsArticleModel>>> call({
    String query = 'news',
  }) {
    return repository.getEverything(query: query);
  }
}
