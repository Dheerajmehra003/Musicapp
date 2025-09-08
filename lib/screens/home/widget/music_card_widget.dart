import 'package:flutter/material.dart';
import 'package:musicapp/widgets/text_widget.dart';

class MusicCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double width;
  final double height;

  const MusicCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.width = 130,
    this.height = 130,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5), // spacing between image and text
          Container(
            width: width,
            child: TextWidget(
              title: title,
              size: 12,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
