import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final SearchController _searchController = SearchController();

  void _handleQuerySubmitted(String query) {
    _searchController.closeView(query);

    context.read<SearchBloc>().add(
          SearchQuery(query: query.trim()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (_, SearchState state) {
        return SearchAnchor(
          searchController: _searchController,
          dividerColor: Colors.transparent,
          viewHintText: 'What do you want to seek?',
          viewOnSubmitted: _handleQuerySubmitted,
          viewShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          suggestionsBuilder: (_, __) {
            return state.suggestions.map(
              (String suggestion) {
                return ListTile(
                  leading: const Icon(Icons.history_rounded),
                  title: Text(suggestion),
                  onTap: () {
                    _handleQuerySubmitted(suggestion);
                  },
                );
              },
            );
          },
          builder: (_, SearchController controller) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.openView,
              child: IgnorePointer(
                child: SearchBar(
                  controller: controller,
                  onTap: controller.openView,
                  hintText: 'What do you want to seek?',
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  leading: const Icon(Icons.search),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
