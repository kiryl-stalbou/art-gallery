import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../di/app_di.dart';
import '../../../../core_ui/html_text.dart';
import '../../../../data/models/details/art_details.dart';
import '../../../../navigation/router.dart';

class DetailsSuccessWidget extends StatelessWidget {
  final ArtDetails artDetails;

  const DetailsSuccessWidget({
    required this.artDetails,
    super.key,
  });

  void _handleImageTap() {
    router.push(
      ImageRoute(imageUrl: artDetails.imageUrl),
    );
  }

  void _handleLinkTap(String url) {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return;

    launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      children: <Widget>[
        //
        GestureDetector(
          onTap: _handleImageTap,
          child: SizedBox(
            height: 300,
            child: CachedNetworkImage(
              imageUrl: artDetails.imageUrl,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 80,
                );
              },
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //
              Text(
                artDetails.title,
                style: textTheme.headlineMedium,
              ),

              if (artDetails.date != null || artDetails.origin != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    <String?>[
                      artDetails.origin,
                      artDetails.date,
                    ].whereType<String>().join(', '),
                    style: textTheme.titleMedium,
                  ),
                ),

              if (artDetails.artist != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    artDetails.artist!,
                    style: textTheme.titleMedium,
                  ),
                ),

              if (artDetails.categories?.isNotEmpty == false ||
                  artDetails.techniques?.isNotEmpty == false)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    <String?>[
                      ...?artDetails.categories,
                      ...?artDetails.techniques,
                    ].whereType<String>().join(', '),
                    style: textTheme.titleMedium,
                  ),
                ),

              if (artDetails.medium != null || artDetails.dimensions != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    <String?>[
                      artDetails.medium,
                      artDetails.dimensions,
                    ].whereType<String>().join(', '),
                    style: textTheme.titleMedium,
                  ),
                ),

              if (artDetails.description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: HtmlText(
                    artDetails.description!,
                    onLinkTap: _handleLinkTap,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
