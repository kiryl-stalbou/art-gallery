part of 'search_bloc.dart';

sealed class SearchPaginationState {
  const SearchPaginationState();
}

final class SearchPaginationLoading extends SearchPaginationState {
  const SearchPaginationLoading();
}

final class SearchPaginationFailure extends SearchPaginationState {
  final int limit;
  final int currentPage;

  const SearchPaginationFailure({
    required this.limit,
    required this.currentPage,
  });
}

final class SearchPaginationSuccess extends SearchPaginationState {
  final PageConfig pageConfig;

  const SearchPaginationSuccess({
    required this.pageConfig,
  });
}
