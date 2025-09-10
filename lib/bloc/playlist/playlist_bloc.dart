import 'package:bloc/bloc.dart';
import 'package:musicapp/repositories/playlistrepo/playlistrepository.dart';

import 'playlist_event.dart';
import 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final JamendoRepository repository;
  PlaylistBloc(this.repository) : super(PlaylistInitial()) {
    on<LoadPlaylists>((event, emit) async {
      emit(PlaylistLoading());
      try {
        // Pass the optional tag from the event
        final playlists = await repository.getPlaylists(tag: event.tag);
        emit(PlaylistLoaded(playlists));
      } catch (e) {
        emit(PlaylistError(e.toString()));
      }
    });
  }
}
