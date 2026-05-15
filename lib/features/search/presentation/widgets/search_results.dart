import 'package:flutter/material.dart';
import 'package:newsapp/core/enum/enum_status.dart';
import 'package:newsapp/features/search/presentation/controller/search_controller.dart';
import 'package:newsapp/features/search/presentation/widgets/article_card.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatelessWidget {
  final TextEditingController searchController;

  const SearchResults({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsSearchController>(
      builder: (context, controller, _) {
        if (controller.searchStatus == RequestStatusEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchStatus == RequestStatusEnum.error) {
          return _buildErrorState(controller, searchController);
        }

        if (controller.searchResultsList.isEmpty) {
          return _buildEmptyState();
        }

        return _buildResultsList(controller);
      },
    );
  }

  Widget _buildErrorState(
    NewsSearchController controller,
    TextEditingController searchController,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 70, color: Colors.red),
          const SizedBox(height: 16),
          Text(controller.searchError ?? "Error occurred", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.searchNews(searchController.text),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/smartphone.png', height: 70),
          SizedBox(height: 16),
          Text(
            'Search for news',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(NewsSearchController controller) {
    return ListView.builder(
      itemCount: controller.searchResultsList.length,
      itemBuilder: (context, index) {
        final article = controller.searchResultsList[index];
        return ArticleCard(
          article: article,
          onTap: () {
          },
        );
      },
    );
  }
}
