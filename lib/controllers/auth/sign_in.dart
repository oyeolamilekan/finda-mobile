import 'dart:convert';

import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/models.dart';
import '../../network/auth.dart';
import '../../services/user/user_service.dart';
import '../../set_up.dart';

class SignInController extends GetxController {
  bool isPasswordVisible = true;
  AppState loadingState = AppState.none;
  final UserSerivce _userSerivce = locator<UserSerivce>();
  final Authenication _auth = locator<Authenication>();
  late User userModel;

  String? get userId => _userSerivce.userId;

  bool get isLoggedIn => _userSerivce.userId != null;

  void togglePasswordAction() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> signInAction(String email, String password) async {
    try {
      loadingState = AppState.loading;
      update();
      final response = await _auth.login(email, password);
      loadingState = AppState.success;
      userModel = User.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      if (!userModel.isVerified!) {
        FindaStyles.errorSnackBar(
          "Error",
          "You have to verify your email, before you can login.",
        );
        loadingState = AppState.error;
      } else {
        await _userSerivce.saveUserBody(response.body);
        await _userSerivce.saveUserId(userModel.userId ?? "");
        Get.offAllNamed('/index');
      }
    } catch (e) {
      loadingState = AppState.error;
      final String message = await ApiError.convertExceptionToString(
        e as Exception,
      );
      FindaStyles.errorSnackBar(
        "Authentication Error",
        message,
      );
    }
    update();
  }

  Future<void> signInWithoutPassword() async {
    try {
      loadingState = AppState.loading;
      update();
      final response = await _auth.getToken();
      loadingState = AppState.success;
      userModel = User.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      if (!userModel.isVerified!) {
        FindaStyles.errorSnackBar(
          "Error",
          "You have to verify your email, before you can login.",
        );
        loadingState = AppState.error;
      } else {
        await _userSerivce.saveUserBody(response.body);
        Get.offAllNamed('/index');
      }
    } catch (e) {
      loadingState = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        "Authentication Error",
        message,
      );
    }
    update();
  }
}
