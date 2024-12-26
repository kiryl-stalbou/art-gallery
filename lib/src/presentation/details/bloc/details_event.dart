part of 'details_bloc.dart';

sealed class DetailsEvent {
  const DetailsEvent();
}

final class DetailsFetch extends DetailsEvent {
  final int artId;

  const DetailsFetch({
    required this.artId,
  });
}

final class DetailsFetchRetry extends DetailsEvent {
  const DetailsFetchRetry();
}
