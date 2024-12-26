import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlText extends StatelessWidget {
  final String data;
  final void Function(String)? onLinkTap;

  const HtmlText(
    this.data, {
    this.onLinkTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: <String, Style>{
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        'p': Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
        ),
      },
      onLinkTap: (String? url, __, ___) {
        if (url == null) return;
        onLinkTap?.call(url);
      },
    );
  }
}
