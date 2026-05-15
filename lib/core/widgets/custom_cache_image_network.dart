// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:newsapp/core/constant/app_sizes.dart';
// import 'package:shimmer/shimmer.dart';

// class CustomCacheImageNetwork extends StatelessWidget {
//   const CustomCacheImageNetwork({
//     super.key,
//     required this.imageUrl,
//     this.width,
//     this.height,
//   });
//   final String imageUrl;
//   final double? width;
//   final double? height;

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       width: width ?? AppSizes.w120,
//       height: height ?? AppSizes.h70,
//       fit: BoxFit.cover,
//       placeholder: (context, url) => Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Container(
//           height: height ?? AppSizes.h80,
//           width: width ?? AppSizes.w120,
//           color: Colors.white,
//         ),
//       ),
//       errorWidget: (context, url, error) => Icon(Icons.error),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';

class CustomCacheImageNetwork extends StatelessWidget {
  const CustomCacheImageNetwork({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });
  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? AppSizes.w120,
      height: height ?? AppSizes.h70,
      fit: BoxFit.cover,
      // ✅ شلنا Shimmer. خليها Container بس
      // skeletonizer هو اللي هيعمل shimmer للكل
      placeholder: (context, url) => Container(
        height: height ?? AppSizes.h80,
        width: width ?? AppSizes.w120,
        color: Colors.grey[300],
      ),
      errorWidget: (context, url, error) =>
          Container(color: Colors.grey[300], child: const Icon(Icons.error)),
    );
  }
}
