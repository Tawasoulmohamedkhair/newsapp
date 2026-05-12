import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingEntity entity;

  const OnboardingPageContent({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(entity.image)),
        SizedBox(height: AppSizes.ph24),
        Text(
          entity.title,
          style: const TextStyle(
            fontSize: 20, // لو عندك AppSizes.sp20 يبقى استخدميه
            color: Color(0xFF4E4B66),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSizes.ph12),
        Text(
          entity.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6E7191),
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
