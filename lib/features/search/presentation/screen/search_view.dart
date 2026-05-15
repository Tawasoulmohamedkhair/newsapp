import 'package:flutter/material.dart';
import 'package:newsapp/features/search/presentation/controller/search_controller.dart';
import 'package:newsapp/features/search/presentation/widgets/search_results.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search TextField
            TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<NewsSearchController>().searchNews(query);
              },
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<NewsSearchController>().clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),

            const SizedBox(height: 24),

            // Results Area
            Expanded(child: SearchResults(searchController: _searchController)),
          ],
        ),
      ),
    );
  }
}
