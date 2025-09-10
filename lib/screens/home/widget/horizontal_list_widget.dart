import 'package:flutter/material.dart';

import 'music_card_widget.dart';

class HorizontalMusicList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const HorizontalMusicList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // increased height to fit artist name
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              // Pass playlist info if needed
              Navigator.pushNamed(
                context,
                '/playlist',
                arguments: {
                  'playlistId': item['id'].toString(),
                  'playlistName': item['title'].toString(),
                },
              );
            },
            child: Container(
              width: 140,
              margin: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MusicCard(
                    imagePath: item['image'] ?? '',
                    title: item['title'] ?? '',
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['artist'] ?? '',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
