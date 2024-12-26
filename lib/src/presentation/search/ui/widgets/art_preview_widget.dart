import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/preview/art_preview.dart';

class ArtPreviewWidget extends StatelessWidget {
  final ArtPreview artPreview;
  final void Function(ArtPreview) onArtPreviewTap;

  const ArtPreviewWidget({
    required this.artPreview,
    required this.onArtPreviewTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox.square(
        dimension: 70,
        child: CachedNetworkImage(
          imageUrl: artPreview.imageUrl,
          fit: BoxFit.contain,
          errorWidget: (_, __, ___) {
            return const Icon(
              Icons.image_not_supported_outlined,
              size: 40,
            );
          },
        ),
      ),
      title: Text(
        artPreview.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        <String?>[
          artPreview.artist,
          artPreview.date,
        ].whereType<String>().join(', '),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => onArtPreviewTap(artPreview),
    );
  }
}
