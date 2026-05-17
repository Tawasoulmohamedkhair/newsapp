import 'package:flutter/material.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AppStatus { loading, onboarding, loggedOut, loggedIn }

class AppFlowController extends ChangeNotifier {
  AppStatus _status = AppStatus.loading;
  bool _onboardingCompleted = false;

  AppStatus get status => _status;
  bool get onboardingCompleted => _onboardingCompleted;

  Future<void> init() async {
    final prefs =getIt<SharedPreferences>();
    _onboardingCompleted = prefs.getBool('is_onboarding_finished_v3') ?? false;

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (_status == AppStatus.loading) return;

      final newStatus = data.session != null
          ? AppStatus.loggedIn
          : AppStatus.loggedOut;

      if (_status != newStatus) {
        _status = newStatus;
        notifyListeners();
      }
    });
  }

  Future<void> finishSplash() async {
    if (!_onboardingCompleted) {
      _status = AppStatus.onboarding;
    } else {
      final session = Supabase.instance.client.auth.currentSession;
      _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
    }
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs =getIt<SharedPreferences>();
    // ✅ بنحفظ بنفس الـ Key الجديد
    await prefs.setBool('is_onboarding_finished_v3', true);
    _onboardingCompleted = true;

    final session = Supabase.instance.client.auth.currentSession;
    _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
    notifyListeners();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();


    _status = AppStatus.loggedOut;
    notifyListeners();
  }

  void markAsLoggedIn() {
    if (_status != AppStatus.loggedIn) {
      _status = AppStatus.loggedIn;
      notifyListeners();
    }
  }
}
