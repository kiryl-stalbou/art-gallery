import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/details_bloc.dart';

class DetailsFailureWidget extends StatefulWidget {
  const DetailsFailureWidget({super.key});

  @override
  State<DetailsFailureWidget> createState() => _DetailsFailureWidgetState();
}

class _DetailsFailureWidgetState extends State<DetailsFailureWidget> {
  void _handleRetryTap() {
    context.read<DetailsBloc>().add(
          const DetailsFetchRetry(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //
            Icon(
              Icons.error_outline,
              size: 50,
              color: colorScheme.error,
            ),

            Text(
              'Oops! Something went wrong. Please try again.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),

            FilledButton.tonal(
              onPressed: _handleRetryTap,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
