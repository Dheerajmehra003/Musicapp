import 'package:flutter/material.dart';

import 'music_card_widget.dart';

class HorizontalMusicList extends StatelessWidget {
  final List<Map<String, String>> items;

  const HorizontalMusicList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/playlist');
            },
            child: MusicCard(
              imagePath: items[index]['image']!,
              title: items[index]['title']!,
            ),
          );
        },
      ),
    );
  }
}
