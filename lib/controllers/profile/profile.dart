import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/models.dart';
import '../../network/auth.dart';
import '../../set_up.dart';

class ProfileController extends GetxController {
  final Authenication auth = locator<Authenication>();
  final SharedPreferences sharedPreferences = locator<SharedPreferences>();
  final ImagePicker imagePicker = locator<ImagePicker>();
  final SharedPreferences sharedPrefrence = locator<SharedPreferences>();

  late PackageInfo packageInfo;
  AppState loading = AppState.loading;
  AppState imageUploading = AppState.none;
  late User user;
  Map<String, dynamic>? data;
  late bool isDarkMode;
  late String message;

  @override
  Future<void> onInit() async {
    isDarkMode = sharedPrefrence.get("isDark") as bool? ?? false;
    await getAppVersion();
    await getUserComplete();
    super.onInit();
  }

  Future<void> getUserComplete() async {
    try {
      loading = AppState.loading;
      update();
      final response = await auth.getUser();
      data = json.decode(response.body) as Map<String, dynamic>?;
      user = User.fromJson(data!);
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

  Future<void> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();
  }

  void updateFullName(String value) {
    user.fullName = value;
    update();
  }

  void updateUsername(String value) {
    user.username = value;
    update();
  }

  Future<void> uploadImage() async {
    try {
      final file = await (imagePicker.pickImage(
        source: ImageSource.gallery,
      ) as Future<PickedFile>);
      final File _image = File(file.path);
      imageUploading = AppState.loading;
      update();
      final response = await auth.updateProfilePic(_image);
      user = User.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      FindaStyles.successSnackbar(
        "Success",
        "Image has successfully updated.",
      );
      imageUploading = AppState.none;
    } catch (e) {
      imageUploading = AppState.error;
      FindaStyles.errorSnackBar(
        null,
        "message",
      );
    }
    update();
  }

  Future<void> toggleThemMode() async {
    await sharedPrefrence.setBool("isDark", !isDarkMode);
    isDarkMode = sharedPrefrence.get("isDark") as bool? ?? false;
    SystemChrome.setSystemUIOverlayStyle(
        isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
    Get.changeTheme(
      ThemeData(
        fontFamily: "Poppins",
        accentColor: hexToColor("#222222"),
        primaryColor: isDarkMode ? hexToColor("#222222") : Colors.white,
        disabledColor: Colors.grey,
        textTheme: TextTheme(
          button: TextStyle(
            color: isDarkMode ? hexToColor("#222222") : Colors.white,
          ),
        ),
        iconTheme: isDarkMode
            ? const IconThemeData(color: Colors.white)
            : IconThemeData(color: hexToColor("#121212")),
        cardColor: isDarkMode ? Colors.white : hexToColor("#222222"),
        canvasColor: isDarkMode ? hexToColor("#222222") : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        indicatorColor: isDarkMode ? Colors.white : hexToColor("#222222"),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
      ),
    );
  }
}
