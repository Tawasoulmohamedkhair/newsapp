// import 'package:flutter/material.dart';
// import 'package:newsapp/core/di/service_locator.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../../../core/constant/app_sizes.dart';
// import '../controller/onboarding_controller.dart';
// import 'package:newsapp/features/onboarding/presentation/widgets/onboarding_page_view.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: getIt<OnboardingController>(),
//       child: Consumer<OnboardingController>(
//         builder: (context, controller, child) {
//           if (controller.isLoading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           if (controller.errorMessage != null) {
//             return Scaffold(
//               body: Center(child: Text('Error: ${controller.errorMessage}')),
//             );
//           }

//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: const Color(0xFFf5f5f5),
//               elevation: 0,
//               actions: [
//                 if (!controller.isLastPage)
//                   TextButton(
//                     onPressed: () => controller.finishOnboarding(),
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
//                           entity: controller.pages[index],
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
//                           controller.finishOnboarding();
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
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/next_button.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/onboarding_page_view.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<OnboardingController>(),
      child: Consumer<OnboardingController>(
        builder: (context, controller, child) {
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

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFf5f5f5),
              elevation: 0,
              actions: [if (!controller.isLastPage) const SkipButton()],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.ph30,
                horizontal: AppSizes.pw16,
              ),
              child: Column(
                children: [
                  Expanded(child: OnboardingPageViewWidget()),
                  PageIndicatorWidget(),
                  SizedBox(height: AppSizes.ph112),
                  NextButtonWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
