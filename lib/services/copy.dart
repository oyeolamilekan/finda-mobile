import 'package:flutter/services.dart';

/// Built by samazidi
/// A Flutter Clipboard Plugin.
class FlutterClipboard {
  /// copy receives a string text and saves to Clipboard
  /// returns void
  static Future<void> copy(String text) async {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      return;
    } else {
      throw 'Please enter a string';
    }
  }

  /// Paste retrieves the data from clipboard.
  static Future<String> paste() async {
    final ClipboardData data =
        await (Clipboard.getData('text/plain') as Future<ClipboardData>);
    return data.text.toString();
  }

  /// controlC receives a string text and saves to Clipboard
  /// returns boolean value
  static Future<bool> controlC(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      return false;
    }
  }

  /// controlV retrieves the data from clipboard.
  /// same as paste
  /// But returns dynamic data
  static Future<dynamic> controlV() async {
    final ClipboardData? data = await Clipboard.getData('text/plain');
    return data;
  }
}
