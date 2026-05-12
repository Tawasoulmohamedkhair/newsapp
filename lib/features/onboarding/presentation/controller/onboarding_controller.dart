import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/core/usecases/usecase.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
import 'package:newsapp/features/onboarding/domain/usecases/getonboarding_data.dart';

class OnboardingController extends ChangeNotifier {
  final AppFlowController _appFlowController;
  final GetOnboardingData _getOnboardingDataUseCase;
  final GoRouter _goRouter; 

  final PageController pageController = PageController();

  List<OnboardingEntity> pages = [];
  int _currentPage = 0;

  bool isLoading = true;
  String? errorMessage;

  OnboardingController({
    required AppFlowController appFlowController,
    required GetOnboardingData getOnboardingDataUseCase,
    required GoRouter goRouter,
  }) : _appFlowController = appFlowController,
       _getOnboardingDataUseCase = getOnboardingDataUseCase,
       _goRouter = goRouter {
    fetchOnboardingData();
  }

  bool get isLastPage => _currentPage == pages.length - 1;
  int get totalPages => pages.length;

  Future<void> fetchOnboardingData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getOnboardingDataUseCase(NoParams());

    result.fold(
      (Failure failure) {
        isLoading = false;
        errorMessage = failure.message;
        notifyListeners();
      },
      (List<OnboardingEntity> data) {
        isLoading = false;
        pages = data;
        notifyListeners();
      },
    );
  }

  void onPageChange(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> finishOnboarding() async {
    await _appFlowController.completeOnboarding();
    _goRouter.go('/login');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
