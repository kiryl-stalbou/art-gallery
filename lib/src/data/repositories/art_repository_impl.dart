import 'package:dio/dio.dart';

import '../inputs/fetch_art_details_input.dart';
import '../inputs/search_art_previews_input.dart';
import '../models/details/art_details.dart';
import '../models/pagination/pagination.dart';
import '../models/preview/art_preview.dart';
import 'art_repository.dart';

class ArtRepositoryImpl implements ArtRepository {
  final Dio _dio;

  ArtRepositoryImpl(this._dio);

  @override
  Future<PageResponse<ArtPreview>> searchArtPreviews(
    SearchArtPreviewsInput input,
  ) async {
    final Response<Object> response = await _dio.get(
      '/artworks/search',
      queryParameters: <String, Object>{
        'q': input.query,
        'page': input.page,
        'limit': input.limit,
        'fields': <String>[
          'id',
          'title',
          'image_id',
          'date_display',
          'artist_display',
          'place_of_origin',
        ].join(','),
      },
    );

    if (response.statusCode != 200) throw Exception();

    return PageResponse<ArtPreview>.fromJson(
      response.data as Map<String, Object?>,
      (Object? data) => ArtPreview.fromJson(data as Map<String, Object?>),
    );
  }

  @override
  Future<ArtDetails> fetchArtDetails(
    FetchArtDetailsInput input,
  ) async {
    final Response<Object> response = await _dio.get(
      <String>[
        '/artworks',
        input.artId.toString(),
      ].join('/'),
      queryParameters: <String, Object>{
        'fields': <String>[
          'id',
          'title',
          'dimensions',
          'description',
          'image_id',
          'date_display',
          'artist_display',
          'place_of_origin',
          'medium_display',
          'category_titles',
          'technique_titles',
        ].join(','),
      },
    );

    if (response.statusCode != 200) throw Exception();

    return ArtDetails.fromJson(
      (response.data as Map<String, Object?>)['data'] as Map<String, Object?>,
    );
  }
}
