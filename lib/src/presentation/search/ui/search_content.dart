import 'package:flutter/material.dart';

import 'widgets/search_bar_widget.dart';
import 'widgets/search_view_widget.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        //
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SearchBarWidget(),
        ),

        Expanded(
          child: SearchViewWidget(),
        ),
      ],
    );
  }
}
