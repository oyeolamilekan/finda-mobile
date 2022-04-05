import 'package:flutter/material.dart';

import '../const/styles.dart';
import '../extentions/extentions.dart';

class FINDAHandleBar extends StatelessWidget {
  final double? width;
  final double? height;

  const FINDAHandleBar({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 14.w,
      height: height ?? 5,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: hexToColor("#ffffff").withOpacity(
          0.5,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    );
  }
}
