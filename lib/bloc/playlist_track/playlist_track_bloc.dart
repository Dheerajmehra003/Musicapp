import 'package:bloc/bloc.dart';
import 'package:musicapp/bloc/playlist_track/playlist_track_event.dart';
import 'package:musicapp/bloc/playlist_track/playlist_track_state.dart';

import '../../repositories/playlistrepo/playlistrepository.dart';

class PlaylistTracksBloc
    extends Bloc<PlaylistTracksEvent, PlaylistTracksState> {
  final JamendoRepository repository;

  PlaylistTracksBloc(this.repository) : super(PlaylistTracksInitial()) {
    on<LoadPlaylistTracks>((event, emit) async {
      emit(PlaylistTracksLoading());
      try {
        final tracks = await repository.getTracks(event.playlistId);
        emit(PlaylistTracksLoaded(tracks));
      } catch (e) {
        emit(PlaylistTracksError(e.toString()));
      }
    });
  }
}
