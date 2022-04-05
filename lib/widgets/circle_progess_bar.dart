import 'package:flutter/material.dart';

class CircleProgessBar extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  final Color backgroundColor;
  final double width;
  final double height;
  const CircleProgessBar(
      {this.strokeWidth = 2.0,
      this.color = Colors.black,
      this.width = 20,
      this.height = 20,
      this.backgroundColor = Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color?>(color),
      ),
    );
  }
}
