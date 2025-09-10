import 'package:equatable/equatable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayerState extends Equatable {
  final bool isVisible;
  final bool isPlaying;
  final String? title;
  final String? artist;
  final String? image;
  final PanelController? panelController;
  final String? audioUrl; // NEW

  const PlayerState({
    this.isVisible = false,
    this.isPlaying = false,
    this.title,
    this.artist,
    this.image,
    this.panelController,
    this.audioUrl,
  });

  PlayerState copyWith({
    bool? isVisible,
    bool? isPlaying,
    String? title,
    String? artist,
    String? image,
    PanelController? panelController,
    String? audioUrl,
  }) {
    return PlayerState(
      isVisible: isVisible ?? this.isVisible,
      isPlaying: isPlaying ?? this.isPlaying,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      image: image ?? this.image,
      panelController: panelController ?? this.panelController,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  @override
  List<Object?> get props => [
    isVisible,
    isPlaying,
    title,
    artist,
    image,
    panelController,
    audioUrl,
  ];
}
