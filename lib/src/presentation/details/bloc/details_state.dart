part of 'details_bloc.dart';

sealed class DetailsState {
  const DetailsState();
}

final class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

final class DetailsFailure extends DetailsState {
  final int artId;

  const DetailsFailure({
    required this.artId,
  });
}

final class DetailsSuccess extends DetailsState {
  final ArtDetails artDetails;

  const DetailsSuccess({
    required this.artDetails,
  });
}
