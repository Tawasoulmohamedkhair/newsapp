import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/core/services/auth_service.dart';
import 'package:newsapp/core/state/app_flow_controller.dart'; // Import this
import 'package:newsapp/core/utils/validators/app_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService service;
  final AppFlowController appFlowController; // Add this

  // Update constructor
  AuthProvider(this.service, this.appFlowController) {
    _listenAuth();
  }

  bool isLoading = false;
  String? error;

  bool get isLoggedIn => service.user != null;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ConstantText.emailisrequired;
    }
    if (!AppValidator.isValidEmail(value)) {
      return ConstantText.enteravalidemail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ConstantText.passwordisrequired;
    }
    if (!AppValidator.isValidPassword(value)) {
      return ConstantText.weakpassword;
    }
    return null;
  }

  // 🔥 Register
  Future<bool> register(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      error = await service.register(email, password);

      if (error == null) {
        appFlowController.completeOnboarding();
        return true;
      }

      return false;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // // 🔥 Register
  //   // 🔥 Register
  // Future<bool> register(String email, String password) async {
  //   isLoading = true;
  //   error = null;
  //   notifyListeners();

  //   try {
  //     error = await service.register(email, password);

  //     if (error == null) {
  //       appFlowController.completeOnboarding();

  //       return true;
  //     }

  //     return false;
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // 🔥 Login
  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      error = await service.login(email, password);

      if (error == null) {
        appFlowController.markAsLoggedIn();
        return true;
      }

      return false;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🔥 Logout
  Future<void> logout() async {
    await service.logout();
    PreferencesManager().setBool('isLoggedIn', false);
    // AppFlowController listener will handle routing back to login
    notifyListeners();
  }

  // 🔥 Supabase listener
  void _listenAuth() {
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      notifyListeners();
    });
  }
}
