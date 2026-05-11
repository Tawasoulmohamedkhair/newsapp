import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream();

  void refresh() {
    notifyListeners();
  }
}
