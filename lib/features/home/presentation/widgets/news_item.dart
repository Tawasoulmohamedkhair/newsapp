import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';

class NewsItems extends StatelessWidget {
  final NewsArticleEntity? article;
  final bool isSkeleton;

  const NewsItems({super.key, required this.article}) : isSkeleton = false;

  const NewsItems.skeleton({super.key}) : article = null, isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 100,
              height: 100,
              child: isSkeleton
                  ? Container(color: Colors.white)
                  : CachedNetworkImage(
                      imageUrl: article?.urlToImage ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSkeleton
                      ? 'This is a very long fake title for skeleton loading UI state'
                      : article?.title ?? 'No Title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isSkeleton
                      ? 'This is a fake description that is long enough to take three full lines for skeleton'
                      : article?.description ?? 'No Description Available',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
