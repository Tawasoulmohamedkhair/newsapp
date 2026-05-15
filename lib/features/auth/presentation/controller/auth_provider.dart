import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/core/utils/validators/app_validator.dart';
import 'package:newsapp/features/auth/domain/entities/user_entity.dart';
import 'package:newsapp/features/auth/domain/usecase/login_usecase.dart';
import 'package:newsapp/features/auth/domain/usecase/register_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:newsapp/core/mixin/safe_notify.dart';

class AuthProvider with ChangeNotifier, SafeNotify {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AppFlowController appFlowController;

  late final StreamSubscription<AuthState> _authSubscription;

  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.appFlowController,
  }) {
    _listenAuth();
  }

  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ConstantText.emailisrequired;
    }
    if (!AppValidator.isValidEmail(value.trim())) {
      return ConstantText.enteravalidemail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return ConstantText.passwordisrequired;
    if (!AppValidator.isValidPassword(value)) return ConstantText.weakpassword;
    return null;
  }

  // 🔥 Register
  Future<bool> register(String email, String password) async {
    isLoading = true;
    error = null;
    safeNotifyListeners();

    try {
      final result = await registerUseCase(email, password);

      return result.fold(
        (Failure failure) {
          error = failure.message;
          return false;
        },
        (UserEntity user) async {
          await Supabase.instance.client.auth.signOut();
          return true;
        },
      );
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      safeNotifyListeners();
    }
  }

  // 🔥 Login
  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    safeNotifyListeners();

    try {
      final result = await loginUseCase(email, password);

      return result.fold(
        (Failure failure) {
          error = failure.message;
          return false;
        },
        (UserEntity user) {
          appFlowController.markAsLoggedIn();
          return true;
        },
      );
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      safeNotifyListeners();
    }
  }

  Future<void> logout() async {
    isLoading = true;
    error = null;
    safeNotifyListeners();
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      safeNotifyListeners();
    }
  }

  // 🔥 Supabase listener
  void _listenAuth() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      safeNotifyListeners();
    });
  }
}
