import 'package:flutter/material.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/home/presentation/widgets/categories_widget.dart';
import 'package:newsapp/features/home/presentation/widgets/top_head_lines_widgt.dart';
import 'package:newsapp/features/home/presentation/widgets/trending_news.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(
        getEverythingUseCase: getIt(),
        getTopHeadlinesUseCase: getIt(),
      )..init(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const TrendingNews(),
          const CategoriesWidget(),
          const TopHeadLines(),
        ],
      ),
    );
  }
}
