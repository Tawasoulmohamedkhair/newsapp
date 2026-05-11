
// // import 'package:flutter/material.dart';

// // class OnboardingController extends ChangeNotifier {
// //   final PageController pageController = PageController();
// //   final int totalPages;

// //   OnboardingController({required this.totalPages});

// //   int currentIndex = 0;
// //   bool get isLastPage => currentIndex == totalPages - 1;

// //   void onPageChange(int index) {
// //     currentIndex = index;
// //     notifyListeners();
// //   }

// //   void nextPage() {
// //     pageController.nextPage(
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     pageController.dispose(); // مهم جدا
// //     super.dispose();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:newsapp/features/onboarding/data/datasources/onboarding_local_datasource.dart';
// import 'package:newsapp/features/onboarding/data/model/onboarding_model.dart';
// import '../../../../core/state/app_flow_controller.dart';

// class OnboardingController extends ChangeNotifier {
//   final AppFlowController _appFlowController;
//   final OnboardingLocalDataSource _localDataSource;

//   final PageController pageController = PageController();

//   late List<OnboardingModel> pages;
//   int _currentPage = 0;

//   OnboardingController(this._appFlowController, this._localDataSource) {
//     // نجيب البيانات من الـ Data Source مش من الـ UI
//     pages = _localDataSource.getOnboardingPages();
//   }

//   bool get isLastPage => _currentPage == pages.length - 1;
//   int get totalPages => pages.length;

//   void onPageChange(int index) {
//     _currentPage = index;
//     notifyListeners();
//   }

//   void nextPage() {
//     if (!isLastPage) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     }
//   }

//   // الـ Logic بتاع الروتر والـ AppFlow اتنقل هنا
//   Future<void> finishOnboarding(BuildContext context) async {
//     await _appFlowController.completeOnboarding();
//     if (context.mounted) {
//       // استخدم الـ context هنا أو عن طريق Global Navigator Key
//       // بس كده الـ Controller هو اللي بيتخذ القرار
//       context.go('/login');
//     }
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/core/usecases/usecase.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';
import 'package:newsapp/features/onboarding/domain/usecases/getonboarding_data.dart';

class OnboardingController extends ChangeNotifier {
  final AppFlowController _appFlowController;
  final GetOnboardingData _getOnboardingDataUseCase; // ← استخدمنا الـ Use Case
  final GoRouter _goRouter; // ← حقنا الـ GoRouter

  final PageController pageController = PageController();

  // استخدام Entity مش Model
  List<OnboardingEntity> pages = [];
  int _currentPage = 0;

  // عشان نتحكم في حالة الـ Loading والـ Error في الـ UI
  bool isLoading = true;
  String? errorMessage;

  OnboardingController({
    required AppFlowController appFlowController,
    required GetOnboardingData getOnboardingDataUseCase,
    required GoRouter goRouter,
  }) : _appFlowController = appFlowController,
       _getOnboardingDataUseCase = getOnboardingDataUseCase,
       _goRouter = goRouter {
    // نادي دالة جلب الداتا بمجرد إنشاء الـ Controller
    fetchOnboardingData();
  }

  bool get isLastPage => _currentPage == pages.length - 1;
  int get totalPages => pages.length;

  // 1. دالة جلب البيانات (باستخدام الـ Use Case)
  Future<void> fetchOnboardingData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners(); // عشان الـ UI يعرض Loading

    // بنادي الـ Use Case اللي بيرجع Either
    final result = await _getOnboardingDataUseCase(NoParams());

    result.fold(
      (Failure failure) {
        isLoading = false;
        errorMessage = failure.message; // افترض إن عندك message في الـ Failure
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

  // 2. مفيش BuildContext! بنستخدم الـ GoRouter اللي حقناه
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
