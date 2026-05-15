import 'package:flutter/material.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsapp/core/mixin/safe_notify.dart';
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
    topHeadLinesError = null; 
    getTopHeadLines();
  }

  // 🔥 Top Headlines
  Future<void> getTopHeadLines() async {
    topHeadLinesStatus = RequestStatusEnum.loading;
    topHeadLinesError = null;
    safeNotifyListeners();

    final Either<Failure, List<NewsArticleEntity>> result =
        await getTopHeadlinesUseCase(category: selectedCategory);

    result.fold(
      (Failure failure) {
        topHeadLinesError = failure.message;
        topHeadLinesStatus = RequestStatusEnum.error;
      },
      (List<NewsArticleEntity> articles) {
        newsTopHeadLinesList = articles;
        topHeadLinesStatus = RequestStatusEnum.loaded;
      },
    );

   safeNotifyListeners();
    ();
  }

  // 🔥 Everything
  Future<void> getEveryThing() async {
    everythingStatus = RequestStatusEnum.loading;
    everythingError = null;
   safeNotifyListeners();
    ();

    final Either<Failure, List<NewsArticleEntity>> result =
        await getEverythingUseCase(query: 'news');

    result.fold(
      (Failure failure) {
        everythingError = failure.message;
        everythingStatus = RequestStatusEnum.error;
      },
      (List<NewsArticleEntity> articles) {
        newsEveryThingList = articles;
        everythingStatus = RequestStatusEnum.loaded;
      },
    );

    safeNotifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    newsTopHeadLinesList = [];
    topHeadLinesError = null;
    getTopHeadLines();
  }
}
