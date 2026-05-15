import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/news_item.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart'; // ✅

class TopHeadLines extends StatelessWidget {
  const TopHeadLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, child) {
        
        if (controller.topHeadLinesStatus == RequestStatusEnum.error) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  controller.topHeadLinesError ?? ConstantText.anerroroccurred,
                ),
              ),
            ),
          );
        }
        final isLoading =
            controller.topHeadLinesStatus == RequestStatusEnum.loading;

        return Skeletonizer.sliver(
          
          enabled: isLoading,
          ignoreContainers: true, 
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
          ),
          child: SliverList.builder(
            itemCount: isLoading ? 6 : controller.newsTopHeadLinesList.length,
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return const NewsItems.skeleton(); 
              }
              final article = controller.newsTopHeadLinesList[index];
              return NewsItems(article: article);
            },
          ),
        );
      },
    );
  }
}
