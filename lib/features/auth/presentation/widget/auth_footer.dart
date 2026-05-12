import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/core/constant/app_sizes.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final String route;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        SizedBox(width: AppSizes.pw8),
        InkWell(
          onTap: () => context.go(route),
          child: Text(
            actionText,
            style: const TextStyle(
              color: Color(0xffC53030),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
