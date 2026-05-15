import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/trending_card.dart';
import 'package:newsapp/features/home/presentation/widgets/trending_card_skeleton.dart';
import 'package:newsapp/features/home/presentation/widgets/view_all_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h330,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset(AssetsImage.background, fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: 60,
              child: Column(
                children: [
                  Text(
                    ConstantText.newst,
                    style: TextStyle(
                      color: const Color(0xffC53030),
                      fontSize: AppSizes.sp40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ViewAll(title: ConstantText.trendingnews, onTap: () {
                    Navigator.pushNamed(context, '/trendingcards');
                  }),
                  SizedBox(height: AppSizes.ph10),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder:
                          (
                            BuildContext context,
                            HomeController controller,
                            child,
                          ) {
                            if (controller.everythingStatus ==
                                RequestStatusEnum.error) {
                              return Center(
                                child: Text(
                                  controller.everythingError ??
                                      ConstantText.anerroroccurred,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            final isLoading =
                                controller.everythingStatus ==
                                RequestStatusEnum.loading;

                            return Skeletonizer(
                              enabled: isLoading,
                              ignoreContainers: true,
                              effect: ShimmerEffect(
                                baseColor: Colors.grey.shade800,
                                highlightColor: Colors.grey.shade600,
                              ),
                              child: ListView.separated(
                                padding: EdgeInsets.only(left: AppSizes.pw16),
                                separatorBuilder: (_, _) =>
                                    SizedBox(width: AppSizes.pw12),
                                scrollDirection: Axis.horizontal,
                                itemCount: isLoading
                                    ? 3
                                    : controller.newsEveryThingList
                                          .take(6)
                                          .length,
                                itemBuilder: (context, index) {
                                  if (isLoading) {
                                    return const TrendingCardSkeleton();
                                  }
                                  return TrendingCard(
                                    model: controller.newsEveryThingList[index],
                                  );
                                },
                              ),
                            );
                          },
                    ),
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
