import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/bloc/playerbloc/player_event.dart';
import 'package:musicapp/bloc/playerbloc/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlaySong>((event, emit) {
      emit(
        state.copyWith(
          isVisible: true,
          isPlaying: true,
          title: event.title,
          artist: event.artist,
          image: event.image,
        ),
      );

      state.panelController?.open();
    });

    on<HidePlayer>((event, emit) {
      emit(state.copyWith(isVisible: false));
      state.panelController?.close();
    });

    on<PauseSong>((event, emit) {
      emit(state.copyWith(isPlaying: false));
    });

    on<ResumeSong>((event, emit) {
      emit(state.copyWith(isPlaying: true));
    });

    on<SetPanelController>((event, emit) {
      emit(state.copyWith(panelController: event.controller));
    });

    on<OpenPlayer>((event, emit) {
      state.panelController?.open();
    });

    on<ClosePlayer>((event, emit) {
      state.panelController?.close();
    });
  }
}
