
import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/data/models/news_article_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NewsArticleModel>>> getTopHeadLine({
    String? selectedCategory = "general",
  });

  Future<Either<Failure, List<NewsArticleModel>>> getEverything({
    String? query = "news",
  });
}
