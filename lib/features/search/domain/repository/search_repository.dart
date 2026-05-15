import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<NewsArticleEntity>>> searchNews(String query);
}
