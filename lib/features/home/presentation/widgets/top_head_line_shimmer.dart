import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadLineShimmer extends StatelessWidget {
  const TopHeadLineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.all(16.0.r),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height:AppSizes.h80, color: Colors.white),
          ),
        );
      },
    );
  }
}
