// import 'package:flutter/material.dart';
// import 'package:newsapp/features/onboarding/data/model/onboarding_model.dart';
// import '../../../../core/constant/app_sizes.dart';

// class OnboardingPageContent extends StatelessWidget {
//   final OnboardingModel model;

//   const OnboardingPageContent({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(child: Image.asset(model.image)),
//         SizedBox(height: AppSizes.ph24),
//         Text(
//           model.title,
//           style: const TextStyle(
//             fontSize:
//                 20, // الأفضل تستخدم Theme.of(context).textTheme.headlineSmall
//             color: Color(0xFF4E4B66),
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: AppSizes.ph12),
//         Text(
//           model.description,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Color(0xFF6E7191),
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const Spacer(),
//       ],
//     );
//   }
// }

// في ملف onboarding_page_view.dart

import 'package:flutter/material.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../domain/entities/onboardingentity.dart'; // ← استبدلي الـ Model بالـ Entity

class OnboardingPageContent extends StatelessWidget {
  // غيرنا النوع من Model إلى Entity
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
