import 'package:flutter/material.dart';

class SizeConfig {
  static BuildContext? appContext;
  static late MediaQueryData _mediaQueryData;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
  }

  static double height(double height) {
    final double screenHeight = _mediaQueryData.size.height / 100;
    return (height * screenHeight).round().toDouble();
  }

  static double width(double width) {
    final double screenWidth = _mediaQueryData.size.width / 100;
    return (width * screenWidth).round().toDouble();
  }

  static double textSize(double textSize) {
    final double screenWidth = _mediaQueryData.size.width / 100;
    return (textSize * screenWidth).round().toDouble();
  }
}
