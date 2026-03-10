import 'package:flutter/material.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/features/auth/login_screen.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;
  bool isLastPage = false;

  PageController pageController = PageController();

  void onPageChanged(int index) {
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    currentIndex = index;

    notifyListeners();
  }

  void onFinish(BuildContext context) async {
    await PreferencesManager().setBool('onboardingComplete', true);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
