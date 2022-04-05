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
import 'package:finda/extentions/extentions.dart';

class UserProfileController extends GetxController {
  AppState loading = AppState.none;
  AppState btnLoading = AppState.none;
  final Authenication auth = locator<Authenication>();
  late User user;
  final SharedPreferences sharedPreferences = locator<SharedPreferences>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();

  Map<String, dynamic>? data;

  @override
  Future<void> onInit() async {
    await userDetail();
    super.onInit();
  }

  Future<void> userDetail() async {
    try {
      loading = AppState.loading;
      update();
      final response = await auth.getUser();
      data = json.decode(response.body) as Map<String, dynamic>?;
      user = User.fromJson(data!);
      firstName.text = user.firstName!;
      lastName.text = user.lastName!;
      email.text = user.email!;
      loading = AppState.none;
    } catch (e) {
      loading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }

  Future<void> updateUser(
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      btnLoading = AppState.loading;
      update();
      final response = await auth.updateUser(firstName, lastName, email);
      data = json.decode(response.body) as Map<String, dynamic>?;
      final String user = sharedPreferences.getString("user")!;
      final User userModel = User.fromJson(
        json.decode(user) as Map<String, dynamic>,
      );
      userModel.fullName = "$firstName $lastName";
      userModel.firstName = firstName;
      userModel.lastName = lastName;
      String detail = data!['detail'] as String;
      await sharedPreferences.setString(
        "user",
        json.encode(userModel.toJson()),
      );
      btnLoading = AppState.none;
      FindaStyles.successSnackbar(
        null,
        detail.utf8Convert,
      );
    } catch (e) {
      btnLoading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }
}
