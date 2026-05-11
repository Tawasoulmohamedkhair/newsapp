import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: AppSizes.pw16),
      separatorBuilder: (context, index) {
        return SizedBox(width: AppSizes.w12);
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: AppSizes.h140,
            width: AppSizes.w240,
            color: Colors.white,
          ),
        );
      },
      itemCount: 6,
    );
  }
}
