import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/user_conts.dart';
import '../exception/utils.dart';
import '../models/models.dart';
import '../services/http/base.dart';
import '../set_up.dart';

class Authenication {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };
  final SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  final ApiClient _apiClient = locator<ApiClient>();

  Future<http.Response> login(String email, String password) async {
    final Map<String, String> data = {
      "email": email,
      "password": password,
    };
    final http.Response response = await _apiClient.post(
      "auth/login/",
      data,
    );
    return response;
  }

  Future<http.Response> getToken() async {
    final String userId = sharedPreferences!.getString("user_id") ?? "";

    final Map<String, String> data = {
      "user_id": userId,
    };

    final http.Response response = await _apiClient.post(
      "auth/loginwithphoneauth/",
      data,
    );
    return response;
  }

  Future<http.Response> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String password2,
  ) async {
    final Map<String, String> data = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "password2": password2,
    };
    final http.Response response = await _apiClient.post(
      "auth/register/",
      data,
    );
    return response;
  }

  Future<http.Response> requestPassword(String email) async {
    final Map<String, String> data = {
      "email": email,
    };
    final http.Response response = await _apiClient.post(
      "auth/create_reset_token/",
      data,
    );
    return response;
  }

  Future<http.Response> resetPassword(
    String token,
    String password,
    String confirmPassword,
  ) async {
    final Map<String, String> data = {
      "token": token,
      "password": password,
      "confirmPassword": confirmPassword
    };
    final http.Response response = await _apiClient.post(
      "auth/reset_password_change/",
      data,
    );
    return response;
  }

  Future<http.Response> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final Map<String, String> data = {
      "old_password": oldPassword,
      "new_password": newPassword,
    };
    final http.Response response = await _apiClient.put(
      "auth/change_password/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> getUser() async {
    final http.Response response = await _apiClient.get(
      "auth/profile/user/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> updateProfilePic(File image) async {
    final String user = sharedPreferences!.getString("user")!;
    final User userModel = User.fromJson(
      json.decode(user) as Map<String, dynamic>,
    );
    const String url = '$authUrl/auth/profile/update_profile_pic/';
    final uri = Uri.parse(url);
    final request = http.MultipartRequest("PUT", uri);
    request.headers['authorization'] = 'Bearer ${userModel.token}';
    final stream = http.ByteStream(image.openRead());
    stream.cast();
    final length = await image.length();
    final multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(image.path),
    );
    request.files.add(multipartFile);
    final response = await request.send();
    final streamToResponse = await http.Response.fromStream(response);
    ApiError.checkResponse(streamToResponse.statusCode);
    return streamToResponse;
  }

  Future<http.Response> updateUsername(String username) async {
    final Map<String, String> data = {"username": username};
    final http.Response response = await _apiClient.put(
      "auth/profile/update_user/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> updateUser(
    String firstName,
    String lastName,
    String email,
  ) async {
    final Map<String, String> data = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };
    final http.Response response = await _apiClient.put(
      "auth/profile/update_user/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> updateUserName(String username) async {
    final Map<String, String> data = {
      "username": username,
    };
    final http.Response response = await _apiClient.put(
      "auth/profile/update_username/",
      data,
      auth: true,
    );
    return response;
  }
}
