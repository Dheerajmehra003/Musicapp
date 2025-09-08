import 'package:equatable/equatable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

abstract class PlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaySong extends PlayerEvent {
  final String title;
  final String artist;
  final String image;

  PlaySong({required this.title, required this.artist, required this.image});

  @override
  List<Object?> get props => [title, artist, image];
}

class HidePlayer extends PlayerEvent {}

class PauseSong extends PlayerEvent {}

class ResumeSong extends PlayerEvent {}

/// NEW EVENT: set panel controller (once, from PlayerPanel)
class SetPanelController extends PlayerEvent {
  final PanelController controller;
  SetPanelController(this.controller);
}

/// NEW EVENT: open full player
class OpenPlayer extends PlayerEvent {}

/// NEW EVENT: close to mini player
class ClosePlayer extends PlayerEvent {}
