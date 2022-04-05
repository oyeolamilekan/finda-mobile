import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> redirectToAppStore() async {
  /**
   * Redirects the user to app store redirect link
   */
  if (Platform.isAndroid) {
    launchUrl(
      "https://play.google.com/store/apps/details?id=co.appstate.finda",
    );
  } else {
    launchUrl(
      "https://NaToBuyIosLicenceRemain",
    );
  }
}

Future<void> launchUrl(String url) async {
  /**
   * Launches the string, plus checks if the string is launchable 
   */
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
