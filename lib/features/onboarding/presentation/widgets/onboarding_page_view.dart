import 'package:flutter/material.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:newsapp/features/onboarding/presentation/widgets/onboardingpage_content.dart';
import 'package:provider/provider.dart';

class OnboardingPageViewWidget extends StatelessWidget {
  const OnboardingPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardingController>();
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: controller.onPageChange,
      itemCount: controller.pages.length,
      itemBuilder: (context, index) {
        return  OnboardingPageContent(
          entity: controller.pages[index],
        );
      },
    );
  }
}
