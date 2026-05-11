// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart'; // استخدم GoRouter
// // import 'package:newsapp/core/constant/app_sizes.dart';
// // import 'package:newsapp/core/state/app_flow_controller.dart';
// // import 'package:newsapp/features/onboarding/data/model/onboarding_model.dart';
// // import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
// // import 'package:provider/provider.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// // class OnboardingScreen extends StatelessWidget {
// //   const OnboardingScreen({super.key});

// //   static const List<OnboardingModel> onboardingList = [
// //     OnboardingModel(
// //       image: 'assets/images/onboarding1.png',
// //       title: 'Trending News',
// //       description:
// //           'Stay in the loop with the biggest breaking stories in a stunning visual slider. Just swipe to explore what’s trending right now!',
// //     ),
// //     OnboardingModel(
// //       image: 'assets/images/onboarding2.png',
// //       title: 'Pick What You Love',
// //       description:
// //           'No more endless scrolling! Tap into your favorite topics like Tech, Politics, or Sports and get personalized news in seconds',
// //     ),
// //     OnboardingModel(
// //       image: 'assets/images/onboarding3.png',
// //       title: 'Save It. Read It Later. Stay Smart.',
// //       description:
// //           'Found something interesting? Tap the bookmark and come back to it anytime. Never lose a great read again!',
// //     ),
// //   ];

// //   Future<void> _onFinish(BuildContext context) async {
// //      final appFlow = context.read<AppFlowController>();
// //     await appFlow.completeOnboarding(); // ← دي بس

// //     if (context.mounted) {
// //       context.go('/login');
// //     }
// //   }
  

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (context) =>
// //           OnboardingController(totalPages: onboardingList.length),
// //       child: Consumer<OnboardingController>(
// //         builder: (context, controller, child) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: const Color(0xFFf5f5f5),
// //               elevation: 0,
// //               actions: [
// //                 if (!controller.isLastPage)
// //                   TextButton(
// //                     onPressed: () => _onFinish(context),
// //                     child: Text(
// //                       'Skip',
// //                       style: TextStyle(fontSize: AppSizes.sp16),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //             body: Padding(
// //               padding: EdgeInsets.symmetric(
// //                 vertical: AppSizes.ph30,
// //                 horizontal: AppSizes.pw16,
// //               ),
// //               child: Column(
// //                 children: [
// //                   Expanded(
// //                     child: PageView.builder(
// //                       controller: controller.pageController,
// //                       onPageChanged: controller.onPageChange,
// //                       itemCount: onboardingList.length,
// //                       itemBuilder: (context, index) {
// //                         final model = onboardingList[index];
// //                         return Column(
// //                           children: [
// //                             Expanded(child: Image.asset(model.image)),
// //                             SizedBox(height: AppSizes.ph24),
// //                             Text(
// //                               model.title,
// //                               style: TextStyle(
// //                                 fontSize: AppSizes.sp20,
// //                                 color: const Color(0xFF4E4B66),
// //                                 fontWeight: FontWeight.w700,
// //                               ),
// //                             ),
// //                             SizedBox(height: AppSizes.ph12),
// //                             Text(
// //                               model.description,
// //                               textAlign: TextAlign.center,
// //                               style: TextStyle(
// //                                 fontSize: AppSizes.sp16,
// //                                 color: const Color(0xFF6E7191),
// //                                 fontWeight: FontWeight.w400,
// //                               ),
// //                             ),
// //                             const Spacer(),
// //                           ],
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   SmoothPageIndicator(
// //                     controller: controller.pageController,
// //                     count: onboardingList.length, // خليها dynamic
// //                     effect: const SwapEffect(activeDotColor: Color(0xFFC53030)),
// //                   ),
// //                   SizedBox(height: AppSizes.ph112),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (!controller.isLastPage) {
// //                           controller.nextPage();
// //                         } else {
// //                           _onFinish(context);
// //                         }
// //                       },
// //                       child: Text(
// //                         controller.isLastPage ? 'Get Started' : 'Next',
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:newsapp/features/onboarding/data/datasources/onboarding_local_datasource.dart';
// import 'package:newsapp/features/onboarding/presentation/widgets/onboarding_page_view.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../../../core/constant/app_sizes.dart';
// import '../controller/onboarding_controller.dart';
// import '../../../../core/state/app_flow_controller.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // بنحقن الـ Dependencies بتاعت الـ Controller
//     return ChangeNotifierProvider(
//       create: (context) => OnboardingController(
//         context.read<AppFlowController>(),
//         OnboardingLocalDataSourceImpl(), // في المشاريع الكبيرة بنحقنه من برا (get_it)
//       ),
//       child: Consumer<OnboardingController>(
//         builder: (context, controller, child) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: const Color(0xFFf5f5f5),
//               elevation: 0,
//               actions: [
//                 if (!controller.isLastPage)
//                   TextButton(
//                     onPressed: () => controller.finishOnboarding(context),
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(fontSize: AppSizes.sp16),
//                     ),
//                   ),
//               ],
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: AppSizes.ph30,
//                 horizontal: AppSizes.pw16,
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: PageView.builder(
//                       controller: controller.pageController,
//                       onPageChanged: controller.onPageChange,
//                       itemCount: controller.pages.length,
//                       itemBuilder: (context, index) {
//                         return OnboardingPageContent(
//                           model: controller.pages[index],
//                         );
//                       },
//                     ),
//                   ),
//                   SmoothPageIndicator(
//                     controller: controller.pageController,
//                     count: controller.totalPages,
//                     effect: const SwapEffect(activeDotColor: Color(0xFFC53030)),
//                   ),
//                   SizedBox(height: AppSizes.ph112),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (!controller.isLastPage) {
//                           controller.nextPage();
//                         } else {
//                           controller.finishOnboarding(context);
//                         }
//                       },
//                       child: Text(
//                         controller.isLastPage ? 'Get Started' : 'Next',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constant/app_sizes.dart';
import '../controller/onboarding_controller.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/onboarding_page_view.dart';
// لاتنسي استيراد الـ get_it بتاعك
// import '../../../../injection_container.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. بنجيب الـ Controller من الـ get_it مباشرة
    // (متنسيش تعملي import لملف الـ injection_container)
    return ChangeNotifierProvider.value(
      value: getIt<OnboardingController>(),
      child: Consumer<OnboardingController>(
        builder: (context, controller, child) {
          // 2. التعامل مع حالات الـ Loading والـ Error
          if (controller.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.errorMessage != null) {
            return Scaffold(
              body: Center(child: Text('Error: ${controller.errorMessage}')),
            );
          }

          // 3. لو الداتا اتسجلت بنجاح، اعرض الشاشة
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFf5f5f5),
              elevation: 0,
              actions: [
                if (!controller.isLastPage)
                  TextButton(
                    // شيلنا الـ context من هنا
                    onPressed: () => controller.finishOnboarding(),
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: AppSizes.sp16),
                    ),
                  ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.ph30,
                horizontal: AppSizes.pw16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChange,
                      itemCount: controller.pages.length,
                      itemBuilder: (context, index) {
                        // 4. بنمرر الـ Entity مش الـ Model
                        return OnboardingPageContent(
                          entity: controller.pages[index], 
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.totalPages,
                    effect: const SwapEffect(activeDotColor: Color(0xFFC53030)),
                  ),
                  SizedBox(height: AppSizes.ph112),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!controller.isLastPage) {
                          controller.nextPage();
                        } else {
                          // شيلنا الـ context من هنا كمان
                          controller.finishOnboarding();
                        }
                      },
                      child: Text(
                        controller.isLastPage ? 'Get Started' : 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
