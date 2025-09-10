import 'package:equatable/equatable.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object?> get props => [];
}

class LoadPlaylists extends PlaylistEvent {
  final String? tag;
  final int? offset; // optional tag/category

  const LoadPlaylists({this.tag, this.offset});

  @override
  List<Object?> get props => [tag];
}
