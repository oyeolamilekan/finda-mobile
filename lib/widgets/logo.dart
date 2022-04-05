import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../set_up.dart';

class Logo extends StatelessWidget {
  final SharedPreferences? sharedPrefrence = locator<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        "assets/logo/${(sharedPrefrence!.getBool("isDark") ?? false) ? "lightLogo" : "logo"}.png");
  }
}
