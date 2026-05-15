import 'package:dartz/dartz.dart';
import 'package:newsapp/core/datasource/remoteData/news_remote_data_source.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NewsRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NewsArticleEntity>>> searchNews(
    String query,
  ) async {
    try {
      final models = await remoteDataSource.getEverything(query: query);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
