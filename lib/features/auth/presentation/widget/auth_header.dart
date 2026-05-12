import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/core/constant/constant_text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(AssetsImage.logo, height: AppSizes.h45)),
        SizedBox(height: AppSizes.ph20),
        Text(
          ConstantText.welcome,
          style: TextStyle(
            fontSize: AppSizes.sp20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
