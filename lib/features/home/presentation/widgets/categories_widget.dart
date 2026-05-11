import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/features/home/presentation/constants/categories.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/screen/categories_screen.dart';
import 'package:newsapp/features/home/presentation/widgets/view_all_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return SliverToBoxAdapter(
      child: Column(
        children: [
          ViewAll(
            title: ConstantText.categories,
            titlecolor: Color(0xFF141414),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<HomeController>(),
                    child: CategoriesScreen(),
                  ),
                ),
              );
            },
          ),
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
                  final isSelected = controller.selectedCategory == category;

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
                          SizedBox(height: AppSizes.h6),
                          Container(
                            height: AppSizes.h2,
                            color: isSelected ? Colors.red : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
