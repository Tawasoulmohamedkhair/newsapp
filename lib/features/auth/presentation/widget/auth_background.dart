import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/asset_image.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsImage.news),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
