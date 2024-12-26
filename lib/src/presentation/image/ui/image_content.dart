import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageContent extends StatelessWidget {
  final String imageUrl;

  const ImageContent({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return ClipRect(
      child: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
        ),
        imageProvider: CachedNetworkImageProvider(
          imageUrl,
        ),
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
