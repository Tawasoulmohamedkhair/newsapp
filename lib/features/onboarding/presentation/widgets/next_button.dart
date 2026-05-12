import 'package:flutter/material.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardingController>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!controller.isLastPage) {
            controller.nextPage();
          } else {
            controller.finishOnboarding();
          }
        },
        child: Text(controller.isLastPage ? 'Get Started' : 'Next'),
      ),
    );
  }
}
