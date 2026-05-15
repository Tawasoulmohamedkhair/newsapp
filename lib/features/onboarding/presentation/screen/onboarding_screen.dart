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
