import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

@freezed
class PageConfig with _$PageConfig {
  const factory PageConfig({
    required int total,
    required int limit,
    required int offset,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'current_page') required int currentPage,
  }) = _PageConfig;

  const PageConfig._();

  factory PageConfig.fromJson(Map<String, dynamic> json) =>
      _$PageConfigFromJson(json);

  bool get hasMultiplePages => totalPages > 1;
  bool get hasReachedEnd => currentPage >= totalPages;

  bool get shouldShowEndIndicator => hasMultiplePages && hasReachedEnd;
}

@Freezed(genericArgumentFactories: true)
class PageResponse<T> with _$PageResponse<T> {
  const factory PageResponse({
    @JsonKey(name: 'pagination') required PageConfig config,
    @JsonKey(name: 'data') required List<T> items,
  }) = _PageResponse<T>;

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PageResponseFromJson(json, fromJsonT);
}
