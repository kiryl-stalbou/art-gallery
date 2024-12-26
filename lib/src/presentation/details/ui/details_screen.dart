import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/app_di.dart';
import '../bloc/details_bloc.dart';
import 'details_content.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  final int artId;

  const DetailsScreen({
    @PathParam('id') required this.artId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (_) => DetailsBloc(
        artRepository: artRepository,
        artId: artId,
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          bottom: false,
          child: DetailsContent(),
        ),
      ),
    );
  }
}
