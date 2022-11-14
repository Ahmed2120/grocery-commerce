import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.textSize,
    this.color,
    this.isTitle = false,
    this.maxLines = 10,
  }) : super(key: key);
  final String text;
  final double textSize;
  final Color? color;
  bool isTitle;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.w500 : FontWeight.normal,
          color: color),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
