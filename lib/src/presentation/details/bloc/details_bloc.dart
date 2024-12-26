import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/inputs/fetch_art_details_input.dart';
import '../../../data/models/details/art_details.dart';
import '../../../data/repositories/art_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ArtRepository _artRepository;

  DetailsBloc({
    required ArtRepository artRepository,
    required int artId,
  })  : _artRepository = artRepository,
        super(const DetailsLoading()) {
    on<DetailsFetch>(_handleDetailsFetch);
    on<DetailsFetchRetry>(_handleDetailsFetchRetry);

    add(
      DetailsFetch(artId: artId),
    );
  }

  Future<void> _handleDetailsFetch(
    DetailsFetch event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      emit(
        const DetailsLoading(),
      );

      final ArtDetails artDetails = await _artRepository.fetchArtDetails(
        FetchArtDetailsInput(
          artId: event.artId,
        ),
      );

      emit(
        DetailsSuccess(
          artDetails: artDetails,
        ),
      );
    } catch (_) {
      emit(
        DetailsFailure(
          artId: event.artId,
        ),
      );
    }
  }

  Future<void> _handleDetailsFetchRetry(
    DetailsFetchRetry event,
    Emitter<DetailsState> emit,
  ) async {
    final DetailsState state = this.state;
    if (state is! DetailsFailure) return;

    add(
      DetailsFetch(
        artId: state.artId,
      ),
    );
  }
}
