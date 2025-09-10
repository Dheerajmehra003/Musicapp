import 'package:flutter/material.dart';
import 'package:musicapp/screens/playlist/widget/single_row_music_widget.dart';

class SongList extends StatelessWidget {
  final List<Map<String, dynamic>> songs;

  const SongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];

        return SongRow(
          index: index + 1,
          image: song['image'] != null && song['image'].toString().isNotEmpty
              ? song['image'].toString()
              : 'assets/images/africangirl.png', // fallback image
          title: song['title']?.toString() ?? 'Unknown Title',
          artist: song['artist']?.toString() ?? 'Unknown Artist',
          duration: song['duration']?.toString() ?? '3:45',
          audioUrl: song['audio']?.toString() ?? '',
        );
      },
    );
  }
}
