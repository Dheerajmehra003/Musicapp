import 'package:equatable/equatable.dart';

abstract class PlaylistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<Map<String, dynamic>> playlists;
  PlaylistLoaded(this.playlists);
  @override
  List<Object?> get props => [playlists];
}

class PlaylistError extends PlaylistState {
  final String message;
  PlaylistError(this.message);
  @override
  List<Object?> get props => [message];
}
