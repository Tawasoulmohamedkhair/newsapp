
import 'package:flutter/material.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/features/home/domain/usecases/get_everything_usecase.dart';
import 'package:newsapp/features/search/presentation/controller/search_controller.dart';
import 'package:newsapp/features/search/presentation/screen/search_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsSearchController>(
      create: (_) => NewsSearchController(
        getEverythingUseCase: getIt<GetEverythingUseCase>(), searchNewsUseCase: getIt(),
      ),
      child: const SearchView(),
    );
  }
}


