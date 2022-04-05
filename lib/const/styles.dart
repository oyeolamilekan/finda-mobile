import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class FindaStyles {
  static void successSnackbar(String? title, String message) {
    return Get.snackbar(
      title ?? 'Success.',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      borderRadius: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      backgroundColor: hexToColor("#000000"),
    );
  }

  static void errorSnackBar(
    String? title,
    String message, {
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    return Get.snackbar(
      title ?? 'Error !!!',
      message,
      snackPosition: position,
      colorText: Colors.white,
      borderRadius: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      backgroundColor: hexToColor("#f60200"),
    );
  }
}
