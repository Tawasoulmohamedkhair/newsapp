import 'package:flutter/material.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/core/mixin/safe_notify.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/home/domain/usecases/get_everything_usecase.dart';

class NewsSearchController extends ChangeNotifier with SafeNotify {
  final GetEverythingUseCase getEverythingUseCase;

  NewsSearchController({required this.getEverythingUseCase});

  // State Variables
  RequestStatusEnum searchStatus = RequestStatusEnum.initial;
  List<NewsArticleEntity> searchResultsList = [];
  String? searchError;

  Future<void> searchNews(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      clearSearch();
      return;
    }

    searchStatus = RequestStatusEnum.loading;
    searchError = null;
    safeNotifyListeners();

    final result = await getEverythingUseCase(query: trimmedQuery);

    result.fold(
      (failure) {
        searchError = failure.message;
        searchStatus = RequestStatusEnum.error;
      },
      (articles) {
        searchResultsList = articles;
        searchStatus = RequestStatusEnum.loaded;
      },
    );

    safeNotifyListeners();
  }

  void clearSearch() {
    searchResultsList.clear();
    searchStatus = RequestStatusEnum.initial;
    searchError = null;
    notifyListeners();
  }
}
