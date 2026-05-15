import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NewsArticleEntity>>> getTopHeadlines({
    String category = "general",
  });

  Future<Either<Failure, List<NewsArticleEntity>>> getEverything({
    String query = "news",
  });
}
