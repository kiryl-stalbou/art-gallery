import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/app_di.dart';
import '../../../../data/models/preview/art_preview.dart';
import '../../bloc/search_bloc.dart';
import 'art_preview_widget.dart';
import 'search_pagination_widget.dart';

class SearchSuccessWidget extends StatefulWidget {
  final List<ArtPreview> artPreviews;
  final SearchPaginationState paginationState;

  const SearchSuccessWidget({
    required this.artPreviews,
    required this.paginationState,
    super.key,
  });

  @override
  State<SearchSuccessWidget> createState() => _SearchSuccessWidgetState();
}

class _SearchSuccessWidgetState extends State<SearchSuccessWidget> {
  final ScrollController _scrollController = ScrollController();

  void _handleArtPreviewTap(ArtPreview artPreview) {
    router.pushNamed('/details/${artPreview.id}');
  }

  void _handleSearchScroll() {
    context.read<SearchBloc>().add(
          SearchScroll(
            offset: _scrollController.offset,
            maxOffset: _scrollController.position.maxScrollExtent,
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleSearchScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        //
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          sliver: SliverList.separated(
            separatorBuilder: (_, __) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (_, int index) {
              return ArtPreviewWidget(
                artPreview: widget.artPreviews[index],
                onArtPreviewTap: _handleArtPreviewTap,
              );
            },
            itemCount: widget.artPreviews.length,
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(
            bottom: 60,
          ),
          sliver: SliverToBoxAdapter(
            child: SearchPaginationWidget(
              state: widget.paginationState,
            ),
          ),
        ),
      ],
    );
  }
}
