import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({
    super.key,
    required this.title,
    this.titlecolor,
    required this.onTap,
  });
  final String title;
  final Color? titlecolor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titlecolor ?? Colors.white,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              ConstantText.viewall,
              style: TextStyle(
                color: titlecolor ?? Colors.white,
                fontSize: AppSizes.sp14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: titlecolor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
