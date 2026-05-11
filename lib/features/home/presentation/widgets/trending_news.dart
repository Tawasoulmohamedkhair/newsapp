import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/core/widgets/custom_cache_image_network.dart';
import 'package:newsapp/features/home/presentation/widgets/trending_news_shimmer.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/time_extension.dart';
import 'package:newsapp/features/home/presentation/widgets/view_all_widget.dart';
import 'package:provider/provider.dart';

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
              child: Image.asset(
               AssetsImage.background,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 60,
              child: Column(
                children: [
                  Text(
                    ConstantText.newst,
                    style: TextStyle(
                      color: Color(0xffC53030),
                      fontSize: AppSizes.sp40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ViewAll(title: ConstantText.trendingnews, onTap: () {}),

                  SizedBox(height: AppSizes.ph10),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder: (BuildContext context, HomeController controller, child) {
                        switch (controller.everythingStatus) {
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(
                              child: Text(
                                controller.everythingError ?? ConstantText.anerroroccurred,
                              ),
                            );
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.only(left: AppSizes.pw16),
                              separatorBuilder: (context, index) {
                                return SizedBox(width: AppSizes.pw12);
                              },
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final model =
                                    controller.newsEveryThingList[index];
                                return SizedBox(
                                  width: AppSizes.w240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.r6,
                                    ),

                                    child: Stack(
                                      children: [
                                        CustomCacheImageNetwork(
                                          imageUrl:  model.urlToImage ?? "",
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
                                                  Colors.black.withValues(
                                                    alpha: 0.5,
                                                  ),
                                                  Colors.black.withValues(
                                                    alpha: 0.7,
                                                  ),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title.toString(),
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
                                                          backgroundImage:
                                                              NetworkImage(
                                                                model.urlToImage
                                                                    .toString(),
                                                              ),
                                                        ),
                                                        SizedBox(
                                                          width: AppSizes.pw6,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ??
                                                                ConstantText.unknownAuthor,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  AppSizes.sp12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Text(
                                                    formatTimeAgo(
                                                      model.publishedAt
                                                          .toString(),
                                                    ),
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFCFC),
                                                      fontSize: AppSizes.sp12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                              },
                              itemCount: controller.newsEveryThingList
                                  .take(6)
                                  .length,
                            );
                        }
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
