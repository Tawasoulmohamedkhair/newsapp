import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OnboardingController>();
    return TextButton(
      onPressed: controller.finishOnboarding,
      child: Text('Skip', style: TextStyle(fontSize: AppSizes.sp16)),
    );
  }
}
