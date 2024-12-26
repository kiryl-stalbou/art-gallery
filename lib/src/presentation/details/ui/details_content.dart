import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/art_details.dart';
import '../bloc/details_bloc.dart';
import 'widgets/details_failure_widget.dart';
import 'widgets/details_loading_widget.dart';
import 'widgets/details_success_widget.dart';

class DetailsContent extends StatelessWidget {
  const DetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (_, DetailsState state) {
        return switch (state) {
          DetailsLoading() => const DetailsLoadingWidget(),
          DetailsFailure() => const DetailsFailureWidget(),
          DetailsSuccess(
            :final ArtDetails artDetails,
          ) =>
            DetailsSuccessWidget(
              artDetails: artDetails,
            ),
        };
      },
    );
  }
}
