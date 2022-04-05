import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../set_up.dart';
import 'http_exception.dart';

class ApiError {
  static SharedPreferences? sharedPreferences = locator<SharedPreferences>();

  static void checkResponse(int statusCode) {
    switch (statusCode) {
      case 500:
        throw FetchDataException();
      case 400:
        throw BadRequestException();
      case 409:
        throw ConflictRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 404:
        throw DataNotFoundException();
      case 504:
        throw TimeOutException();
      case 503:
        throw ServiceUnavailable();
      default:
    }
  }

  static Future<String> convertExceptionToString(Exception e) async {
    String message = "Something bad, don't worry we are fixing it.";
    if (e is TimeOutException) {
      message = "There is a time out error, don't worry we are fixing it.";
    } else if (e is SocketException) {
      message = "Please kindly check your internet.";
    } else if (e is BadRequestException) {
      message = "Authentication Failed! Wrong password.";
    } else if (e is ConflictRequestException) {
      message = "Content already exit.";
    } else if (e is DataNotFoundException) {
      message = "Data can't be found.";
    } else if (e is UnauthorisedException) {
      message = "The data you asked for can't be found on our servers.";
      Future.delayed(
        const Duration(seconds: 3),
        () async {
          await sharedPreferences!.remove("is_authenticated");
          await sharedPreferences!.remove("user");
          Get.offAllNamed('/signIn');
        },
      );
    } else if (e is FetchDataException) {
      message = "There is something wrong with our servers.";
    } else if (e is ServiceUnavailable) {
      message = "The server is currently unable to handle your request.";
    } else if (e is TimeOutException) {
      message =
          "Looks like the server is taking to long to respond, please try again in sometime.";
    }
    return message;
  }
}
