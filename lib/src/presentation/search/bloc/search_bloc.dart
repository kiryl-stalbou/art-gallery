import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/inputs/search_art_previews_input.dart';
import '../../../data/models/pagination/pagination.dart';
import '../../../data/models/preview/art_preview.dart';
import '../../../data/repositories/art_repository.dart';

part 'search_event.dart';
part 'search_pagination_state.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ArtRepository _artRepository;

  SearchBloc({
    required ArtRepository artRepository,
  })  : _artRepository = artRepository,
        super(const SearchIdle()) {
    on<SearchQuery>(_handleSearchQuery, transformer: _searchQueryTransformer);
    on<SearchScroll>(_handleSearchScroll);
    on<SearchPaginate>(_handleSearchPaginate);
    on<SearchPaginateRetry>(_handleSearchPaginateRetry);
  }

  Future<void> _handleSearchQuery(
    SearchQuery event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(
        SearchLoading(
          suggestions: state.suggestions,
        ),
      );

      final PageResponse<ArtPreview> response =
          await _artRepository.searchArtPreviews(
        SearchArtPreviewsInput(
          query: event.query,
          limit: 20,
          page: 1,
        ),
      );

      if (response.items.isEmpty) {
        return emit(
          SearchEmpty(
            suggestions: state.suggestions,
          ),
        );
      }

      emit(
        SearchSuccess(
          query: event.query,
          suggestions: <String>{
            if (event.query.isNotEmpty) event.query,
            ...state.suggestions,
          },
          artPreviews: <ArtPreview>[
            ...response.items,
          ],
          paginationState: SearchPaginationSuccess(
            pageConfig: response.config,
          ),
        ),
      );
    } catch (_) {
      emit(
        SearchFailure(
          suggestions: state.suggestions,
        ),
      );
    }
  }

  Future<void> _handleSearchScroll(
    SearchScroll event,
    Emitter<SearchState> emit,
  ) async {
    final SearchState state = this.state;
    if (state is! SearchSuccess) return;

    final SearchPaginationState paginationState = state.paginationState;
    if (paginationState is! SearchPaginationSuccess) return;
    if (paginationState.pageConfig.hasReachedEnd) return;
    if (event.offset < (event.maxOffset * 0.9)) return;

    add(
      SearchPaginate(
        limit: paginationState.pageConfig.limit,
        page: paginationState.pageConfig.currentPage + 1,
      ),
    );
  }

  Future<void> _handleSearchPaginate(
    SearchPaginate event,
    Emitter<SearchState> emit,
  ) async {
    final SearchState state = this.state;
    if (state is! SearchSuccess) return;

    try {
      emit(
        state.copyWith(
          paginationState: const SearchPaginationLoading(),
        ),
      );

      final PageResponse<ArtPreview> response =
          await _artRepository.searchArtPreviews(
        SearchArtPreviewsInput(
          query: state.query,
          limit: event.limit,
          page: event.page,
        ),
      );

      emit(
        state.copyWith(
          artPreviews: <ArtPreview>[
            ...state.artPreviews,
            ...response.items,
          ],
          paginationState: SearchPaginationSuccess(
            pageConfig: response.config,
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          paginationState: SearchPaginationFailure(
            limit: event.limit,
            currentPage: event.page,
          ),
        ),
      );
    }
  }

  Future<void> _handleSearchPaginateRetry(
    SearchPaginateRetry event,
    Emitter<SearchState> emit,
  ) async {
    final SearchState state = this.state;
    if (state is! SearchSuccess) return;

    final SearchPaginationState paginationState = state.paginationState;
    if (paginationState is! SearchPaginationFailure) return;

    add(
      SearchPaginate(
        limit: paginationState.limit,
        page: paginationState.currentPage,
      ),
    );
  }

  Stream<T> _searchQueryTransformer<T>(
    Stream<T> events,
    Stream<T> Function(T) mapper,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap(mapper);
  }
}
