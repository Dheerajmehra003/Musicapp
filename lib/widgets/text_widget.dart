import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final TextAlign? align;
  const TextWidget({
    super.key,
    required this.title,
    this.weight,
    this.size,
    this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      softWrap: true,
      '${title}',
      style: TextStyle(fontWeight: weight, fontSize: size, color: color),
    );
  }
}
