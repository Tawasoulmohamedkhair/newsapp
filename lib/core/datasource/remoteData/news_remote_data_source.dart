

import 'package:newsapp/core/datasource/remoteData/api_service.dart';
import 'package:newsapp/features/home/data/models/news_article_model.dart';

abstract class NewsRemoteDataSource {
  // Home Feature
  Future<List<NewsArticleModel>> getTopHeadlines({String category = "general"});

  // Shared between Home & Search
  Future<List<NewsArticleModel>> getEverything({String query = "news"});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiService apiService;

  NewsRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<NewsArticleModel>> getTopHeadlines({
    String category = "general",
  }) async {
    final result = await apiService.get(
      'top-headlines',
      params: {
        "country": "us",
        "category": category,
      },
    );

    final List articles = result['articles'] ?? [];
    return articles.map((json) => NewsArticleModel.fromJson(json)).toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String query = "news"}) async {
    final result = await apiService.get(
      'everything',
      params: {
        "q": query,
        "language": "en",
        "sortBy": "publishedAt",
        "pageSize": 20,
      },
    );

    final List articles = result['articles'] ?? [];
    return articles.map((json) => NewsArticleModel.fromJson(json)).toList();
  }
}
