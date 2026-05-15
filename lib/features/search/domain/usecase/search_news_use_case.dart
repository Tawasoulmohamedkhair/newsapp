import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/search/domain/repository/search_repository.dart';

class SearchNewsUseCase {
  final SearchRepository searchRepository;

  SearchNewsUseCase(this.searchRepository);

  Future<Either<Failure, List<NewsArticleEntity>>> call(String query) async {
    return await searchRepository.searchNews(query);
  }
}
