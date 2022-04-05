import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../network/auth.dart';
import '../../set_up.dart';

class ChangePasswordController extends GetxController {
  AppState loading = AppState.none;
  Authenication? auth = locator<Authenication>();
  final SharedPreferences? sharedPrefrence = locator<SharedPreferences>();
  Map<String, dynamic>? data;
  String? message;

  Future<void> changePasswordAction(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      loading = AppState.loading;
      update();
      final response = await auth!.changePassword(oldPassword, newPassword);
      data = json.decode(response.body) as Map<String, dynamic>?;
      Get.back();
      FindaStyles.successSnackbar(
        null,
        "Password has been successfully change.",
      );
      loading = AppState.none;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      loading = AppState.error;
      FindaStyles.errorSnackBar(
        null,
        "Something bad happened, we are currently fixing it.",
      );
    }
    update();
  }
}
