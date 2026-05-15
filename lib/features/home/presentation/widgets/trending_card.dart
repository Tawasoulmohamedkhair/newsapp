import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/widgets/custom_cache_image_network.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/home/presentation/widgets/time_extension.dart';

class TrendingCard extends StatelessWidget {
  final NewsArticleEntity model; // ✅ غيرناها من dynamic
  const TrendingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.w240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.r6),
        child: Stack(
          children: [
            CustomCacheImageNetwork(
              imageUrl: model.urlToImage ?? "",
              width: AppSizes.w240,
              height: AppSizes.h140,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: AppSizes.ph6),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: AppSizes.r12,
                              
                              backgroundImage: CachedNetworkImageProvider(
                                model.urlToImage ?? '',
                              ),
                            ),
                            SizedBox(width: AppSizes.pw6),
                            Expanded(
                              child: Text(
                                model.author ?? ConstantText.unknownAuthor,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSizes.sp12,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatTimeAgo(model.publishedAt.toString()),
                        style: TextStyle(
                          color: const Color(0xFFFFFCFC),
                          fontSize: AppSizes.sp12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
