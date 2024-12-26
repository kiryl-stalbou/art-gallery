import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'image_content.dart';

@RoutePage()
class ImageScreen extends StatelessWidget {
  final String imageUrl;

  const ImageScreen({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ImageContent(
        imageUrl: imageUrl,
      ),
    );
  }
}
