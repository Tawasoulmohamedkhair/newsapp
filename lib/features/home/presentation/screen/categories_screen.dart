import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/features/home/presentation/constants/categories.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/news_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstantText.categories), centerTitle: true),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.w16,
                  top: AppSizes.h16,
                  bottom: AppSizes.h16,
                ),
                child: SizedBox(
                  height: AppSizes.h35,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: AppSizes.w16),

                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => SizedBox(width: AppSizes.pw10),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected =
                          controller.selectedCategory == category;

                      return GestureDetector(
                        onTap: () {
                          controller.changeCategory(category);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() +
                                    categories[index].substring(1),
                                style: TextStyle(
                                  color: isSelected ? Colors.red : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: AppSizes.ph4),
                              Container(
                                height: AppSizes.h2,
                                color: isSelected
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadLinesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final article = controller.newsTopHeadLinesList[index];
                    return NewsItems(article: article);
                    
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
