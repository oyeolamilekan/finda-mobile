import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/user.dart';
import '../../network/auth.dart';
import '../../set_up.dart';

class ChangeUsernameController extends GetxController {
  AppState loading = AppState.none;
  AppState btnLoading = AppState.none;
  final Authenication? auth = locator<Authenication>();
  final userName = TextEditingController();
  SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  Map<String, dynamic>? data;
  late User user;
  late String message;

  @override
  Future<void> onInit() async {
    await getUsername();
    super.onInit();
  }

  Future<void> getUsername() async {
    try {
      loading = AppState.loading;
      update();
      final response = await auth!.getUser();
      data = json.decode(response.body) as Map<String, dynamic>?;
      user = User.fromJson(data!);
      userName.text = user.username!;
      loading = AppState.none;
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

  Future<void> updateUsername() async {
    try {
      btnLoading = AppState.loading;
      update();
      final response = await auth!.updateUserName(userName.text);
      data = json.decode(response.body) as Map<String, dynamic>?;
      final String user = sharedPreferences!.getString("user") ?? '';
      final User userModel = User.fromJson(
        json.decode(user) as Map<String, dynamic>,
      );
      data = json.decode(response.body) as Map<String, dynamic>?;
      userModel.username = userName.text;
      btnLoading = AppState.none;
      await sharedPreferences!.setString(
        "user",
        json.encode(userModel.toJson()),
      );
      FindaStyles.successSnackbar(
        null,
        data!['detail'] as String,
      );
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      btnLoading = AppState.error;
    }
    update();
  }
}
