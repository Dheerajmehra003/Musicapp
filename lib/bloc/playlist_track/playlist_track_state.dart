abstract class PlaylistTracksState {}

class PlaylistTracksInitial extends PlaylistTracksState {}

class PlaylistTracksLoading extends PlaylistTracksState {}

class PlaylistTracksLoaded extends PlaylistTracksState {
  final List<Map<String, dynamic>> tracks;

  PlaylistTracksLoaded(this.tracks);
}

class PlaylistTracksError extends PlaylistTracksState {
  final String message;
  PlaylistTracksError(this.message);
}
