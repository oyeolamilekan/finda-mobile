import 'dart:convert';

import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/password_reset_model.dart';
import '../../network/auth.dart';
import '../../set_up.dart';

class PasswordResetController extends GetxController {
  bool isPasswordVisible = true;
  bool isConfirmPassword = true;
  AppState loading = AppState.none;
  final Authenication? auth = locator<Authenication>();
  late PasswordResetModel passwordResetModel;
  late String message;

  void togglePasswordAction() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordAction() {
    isConfirmPassword = !isConfirmPassword;
    update();
  }

  Future<void> requestEmail(String email) async {
    try {
      loading = AppState.loading;
      update();
      final response = await auth!.requestPassword(email);
      passwordResetModel = PasswordResetModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      loading = AppState.success;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      loading = AppState.error;
    }
    update();
  }

  Future<void> resetPassword(
    String token,
    String password,
    String confirmPassword,
  ) async {
    try {
      loading = AppState.loading;
      update();
      final response =
          await auth!.resetPassword(token, password, confirmPassword);
      passwordResetModel = PasswordResetModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      loading = AppState.success;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      loading = AppState.error;
    }
    update();
  }
}
