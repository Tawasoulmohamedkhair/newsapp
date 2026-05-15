import 'package:dartz/dartz.dart';
import 'package:newsapp/core/datasource/remoteData/news_remote_data_source.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NewsRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NewsArticleEntity>>> getTopHeadlines({
    String category = "general",
  }) async {
    try {
      final models = await remoteDataSource.getTopHeadlines(category: category);

      final entities = models.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NewsArticleEntity>>> getEverything({
    String query = "news",
  }) async {
    try {
      final models = await remoteDataSource.getEverything(query: query);

      final entities = models.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
