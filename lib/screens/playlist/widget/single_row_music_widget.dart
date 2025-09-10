import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/playerbloc/player_bloc.dart';
import '../../../bloc/playerbloc/player_event.dart';

class SongRow extends StatelessWidget {
  final int index;
  final String image;
  final String title;
  final String artist;
  final String duration;
  final String audioUrl;

  const SongRow({
    super.key,
    required this.index,
    required this.image,
    required this.title,
    required this.artist,
    required this.duration,
    required this.audioUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Use actual song info here
          context.read<PlayerBloc>().add(
            PlaySong(
              title: title,
              artist: artist,
              image: image,
              audioUrl: audioUrl,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: image.startsWith('http')
                      ? NetworkImage(image) as ImageProvider
                      : AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title & artist
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    artist,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // More options button
            SizedBox(width: 10),
            Icon(Icons.more_horiz, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
