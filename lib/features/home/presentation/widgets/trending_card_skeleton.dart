import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';

class TrendingCardSkeleton extends StatelessWidget {
  const TrendingCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.w240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.r6),
        child: Stack(
          children: [
            Container(color: Colors.white),
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
                  const Text(
                    'This is a very long fake title for skeleton loading UI state',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const CircleAvatar(radius: 12),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'Fake Author Name',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          maxLines: 1,
                        ),
                      ),
                      const Text(
                        '2h ago',
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontSize: 12,
                        ),
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
