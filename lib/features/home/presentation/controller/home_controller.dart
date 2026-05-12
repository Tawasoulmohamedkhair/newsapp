import 'package:flutter/material.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:dartz/dartz.dart'; // Import Either
import 'package:newsapp/core/mixin/safe_notify.dart';
import 'package:newsapp/features/home/data/models/news_article_model.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/home/domain/usecases/get_everything_usecase.dart';
import 'package:newsapp/features/home/domain/usecases/get_top_headlines_usecase.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;
  final GetEverythingUseCase getEverythingUseCase;
  

  HomeController({
    required this.getTopHeadlinesUseCase,
    required this.getEverythingUseCase,
  });

  String selectedCategory = 'business';

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLinesStatus = RequestStatusEnum.loading;

  List<NewsArticleEntity> newsTopHeadLinesList = [];
  List<NewsArticleEntity> newsEveryThingList = [];

  String? topHeadLinesError;
  String? everythingError;

  void init() {
    getTopHeadLines();
    getEveryThing();
  }

  void changeCategory(String category) {
    selectedCategory = category;
    newsTopHeadLinesList = [];
    getTopHeadLines();
  }

  // 🔥 Top Headlines
  Future<void> getTopHeadLines() async {
    topHeadLinesStatus = RequestStatusEnum.loading;
    notifyListeners();

    // Use named parameter: category:
    final Either<Failure, List<NewsArticleModel>> result =
        await getTopHeadlinesUseCase(category: selectedCategory);

    // Handle Either using fold
    result.fold(
      (Failure failure) {
        topHeadLinesError = failure.message;
        topHeadLinesStatus = RequestStatusEnum.error;
      },
      (List<NewsArticleModel> articles) {
        newsTopHeadLinesList = articles.map((e) => e.toEntity()).toList();
        topHeadLinesStatus = RequestStatusEnum.loaded;
      },
    );

    notifyListeners();
  }

  // 🔥 Everything
  Future<void> getEveryThing() async {
    everythingStatus = RequestStatusEnum.loading;
    notifyListeners();

    // Use named parameter: query:
    final Either<Failure, List<NewsArticleModel>> result =
        await getEverythingUseCase(query: 'news');

    // Handle Either using fold
    result.fold(
      (Failure failure) {
        everythingError = failure.message;
        everythingStatus = RequestStatusEnum.error;
      },
      (List<NewsArticleModel> articles) {
        newsEveryThingList = articles.map((e) => e.toEntity()).toList();
        everythingStatus = RequestStatusEnum.loaded;
      },
    );

    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLines();
    safeNotify();
  }
}
