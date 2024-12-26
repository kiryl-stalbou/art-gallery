import 'package:flutter/material.dart';

class DetailsLoadingWidget extends StatelessWidget {
  const DetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
