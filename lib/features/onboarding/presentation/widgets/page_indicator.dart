import 'package:flutter/material.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardingController>();
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: controller.totalPages,
      effect: const SwapEffect(activeDotColor: Color(0xFFC53030)),
    );
  }
}
