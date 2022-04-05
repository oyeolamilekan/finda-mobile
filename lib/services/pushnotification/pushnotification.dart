import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../set_up.dart';
import '../../utils/phone_info.dart';
import '../http/base.dart';

class PushNotification {
  static late final FirebaseMessaging _firebaseMessaging =
      locator<FirebaseMessaging>();
  static late final SharedPreferences _sharedPrefrence =
      locator<SharedPreferences>();
  static final bool isAuthenticated =
      _sharedPrefrence.getBool("is_authenticated") ?? false;

  static Future<void> registerToken() async {
    final Map<String, dynamic>? phoneInfo =
        await DeviceUtils.initPlatformState();
    final ApiClient _client = locator<ApiClient>();

    _firebaseMessaging.getToken().then(
      (value) async {
        final Map<String, dynamic> dataPayload = {
          'current_token': value,
          'phone_brand': phoneInfo!['model'],
          'phone_plaform': Platform.isAndroid
              ? "Android"
              : Platform.isIOS
                  ? 'IOS'
                  : 'Unknown',
          'meta_info': phoneInfo,
        };
        await _client.put(
          "auth/register_phone_token_finda/",
          dataPayload,
          auth: isAuthenticated,
        );
      },
    );
  }
}
