import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/home/domain/repository/home_repository.dart';

class GetTopHeadlinesUseCase {
  final HomeRepository repository;

  const GetTopHeadlinesUseCase(this.repository); // const constructor

  Future<Either<Failure, List<NewsArticleEntity>>> call({
    String category = 'general',
  }) async {
    return await repository.getTopHeadlines(category: category);
  }
}
