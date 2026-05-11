import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/core/constant/apiconfig.dart';
import 'package:newsapp/core/datasource/remoteData/api_service.dart';
import 'package:newsapp/core/error/dio_error_mapper.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/features/home/data/models/news_article_model.dart';
import 'package:newsapp/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getTopHeadLine({
    String? selectedCategory = "general",
  }) async {
    try {
      final result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us", "category": selectedCategory},
      );

      final articles = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();

      return Right(articles);
    } on DioException catch (e) {
      // Extract the Failure that was mapped and attached in AppInterceptors
      final failure = e.error;
      if (failure is Failure) {
        return Left(failure);
      }
      // Fallback mapping just in case
      return Left(DioErrorMapper.map(e));
    } on FormatException catch (_) {
      // Handles JSON parsing errors if the structure is broken
      return const Left(ServerFailure("Invalid response format"));
    } catch (e) {
      // Handles any other unexpected errors
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getEverything({
    String? query = "news",
  }) async {
    try {
      final result = await apiService.get(
        ApiConfig.everyThing,
        params: {"q": query},
      );

      final articles = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();

      return Right(articles);
    } on DioException catch (e) {
      final failure = e.error;
      if (failure is Failure) {
        return Left(failure);
      }
      return Left(DioErrorMapper.map(e));
    } on FormatException catch (_) {
      return const Left(ServerFailure("Invalid response format"));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
