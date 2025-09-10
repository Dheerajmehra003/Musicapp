abstract class PlaylistTracksEvent {}

class LoadPlaylistTracks extends PlaylistTracksEvent {
  final String playlistId;

  LoadPlaylistTracks(this.playlistId);
}
