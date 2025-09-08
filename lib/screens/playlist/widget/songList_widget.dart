import 'package:flutter/material.dart';
import 'package:musicapp/screens/playlist/widget/single_row_music_widget.dart';

class SongList extends StatelessWidget {
  final List<Map<String, String>> songs;

  const SongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // so parent scroll works
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongRow(
          index: index + 1,
          image: song['image']!,
          title: song['title']!,
          artist: song['artist']!,
          duration: song['duration']!,
        );
      },
    );
  }
}
