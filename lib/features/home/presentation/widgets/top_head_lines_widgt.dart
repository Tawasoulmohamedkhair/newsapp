import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/features/home/presentation/widgets/top_head_line_shimmer.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/news_item.dart';
import 'package:provider/provider.dart';

class TopHeadLines extends StatelessWidget {
  const TopHeadLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, child) {
        switch (controller.topHeadLinesStatus) {
          case RequestStatusEnum.loading:
            return TopHeadLineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(controller.topHeadLinesError ?? ConstantText.anerroroccurred),
              ),
            );
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLinesList.length,
              itemBuilder: (BuildContext context, int index) {
                final article = controller.newsTopHeadLinesList[index];
              return   NewsItems(article: article);
                
              },
            );
        }
      },
    );
  }
}
