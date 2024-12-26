import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/pagination/pagination.dart';
import '../../bloc/search_bloc.dart';

class SearchPaginationWidget extends StatefulWidget {
  final SearchPaginationState state;

  const SearchPaginationWidget({
    required this.state,
    super.key,
  });

  @override
  State<SearchPaginationWidget> createState() => _SearchPaginationWidgetState();
}

class _SearchPaginationWidgetState extends State<SearchPaginationWidget> {
  void _handlePaginateRetryTap() {
    context.read<SearchBloc>().add(
          const SearchPaginateRetry(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: switch (widget.state) {
        SearchPaginationLoading() => const CircularProgressIndicator(),
        SearchPaginationFailure() => Column(
            spacing: 5,
            children: <Widget>[
              //
              Icon(
                Icons.warning_amber_rounded,
                size: 30,
                color: colorScheme.error,
              ),

              Text(
                'Failed to load more arts!',
                style: textTheme.bodyMedium,
              ),

              FilledButton.tonal(
                onPressed: _handlePaginateRetryTap,
                child: const Text('Try again'),
              ),
            ],
          ),
        SearchPaginationSuccess(:final PageConfig pageConfig) => Column(
            spacing: 5,
            children: <Widget>[
              //
              if (pageConfig.shouldShowEndIndicator) ...<Widget>[
                //
                const Icon(
                  Icons.done_rounded,
                  size: 30,
                  color: Colors.green,
                ),

                Text(
                  "You're all caught up!",
                  style: textTheme.bodyMedium,
                ),
              ],
            ],
          ),
      },
    );
  }
}
