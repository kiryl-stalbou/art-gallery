import 'package:freezed_annotation/freezed_annotation.dart';

part 'art_details.freezed.dart';
part 'art_details.g.dart';

@freezed
class ArtDetails with _$ArtDetails {
  const factory ArtDetails({
    required int id,
    required String title,
    required String? dimensions,
    required String? description,
    @JsonKey(name: 'image_id') required String? imageId,
    @JsonKey(name: 'date_display') required String? date,
    @JsonKey(name: 'artist_display') required String? artist,
    @JsonKey(name: 'place_of_origin') required String? origin,
    @JsonKey(name: 'medium_display') required String? medium,
    @JsonKey(name: 'category_titles') required List<String>? categories,
    @JsonKey(name: 'technique_titles') required List<String>? techniques,
  }) = _ArtDetails;

  const ArtDetails._();

  factory ArtDetails.fromJson(Map<String, dynamic> json) =>
      _$ArtDetailsFromJson(json);

  String get imageUrl =>
      'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
}
