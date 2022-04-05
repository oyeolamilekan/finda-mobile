import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../network/auth.dart';
import '../../set_up.dart';

class SignUpController extends GetxController {
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  AppState loadingState = AppState.none;
  SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  Authenication? auth = locator<Authenication>();
  String? message = '';

  void togglePasswordAction() {
    isPasswordVisible = !isPasswordVisible;

    update();
  }

  void togglePasswordAction2() {
    isPasswordVisible2 = !isPasswordVisible2;

    update();
  }

  Future<void> signUpAction(
    String email,
    String firstName,
    String lastName,
    String password,
    String password2,
  ) async {
    try {
      loadingState = AppState.loading;
      update();
      final userResponse = await auth!.register(
        firstName,
        lastName,
        email,
        password,
        password2,
      );
      loadingState = AppState.success;
      message = json.decode(userResponse.body)['detail'] as String?;
    } catch (e) {
      loadingState = AppState.error;
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message!);
    }
    update();
  }

  static SignUpController get action => Get.find(); // add this line

}
