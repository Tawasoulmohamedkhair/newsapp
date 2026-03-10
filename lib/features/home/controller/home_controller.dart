import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/apiconfig.dart';
import 'package:newsapp/core/datasource/remoteData/api_service.dart';
import 'package:newsapp/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadLines();
    getEveryThing();
  }
  List<NewsArticleModel> NewsTopHeadLinesList = [];
  List<NewsArticleModel> NewsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  bool topHeadLinesLoading = true;
  bool everyThingLoading = true;

  void getTopHeadLines() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );

      NewsTopHeadLinesList = (result['articles'] as List)
          .map((json) => NewsArticleModel.fromJson(json))
          .toList();
      topHeadLinesLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadLinesLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEveryThing() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everyThing,
        params: {"q": "news"},
      );
      NewsEveryThingList = (result['articles'] as List)
          .map((json) => NewsArticleModel.fromJson(json))
          .toList();
      everyThingLoading = false;
      errorMessage = null;
    } catch (e) {
      everyThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
