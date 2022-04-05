import 'dart:convert';

import '../../models/models.dart';
import '../../set_up.dart';
import '../storage/index.dart';

class UserSerivce {
  final Storage _storage = locator<Storage>();

  User? get user {
    final String? userString = _storage.getString("user");
    return userString != null
        ? User.fromJson(json.decode(userString) as Map<String, dynamic>)
        : null;
  }

  String? get userId {
    final String? userId = _storage.getString("user_id");
    if (userId != null) {
      return userId;
    }
    return null;
  }

  bool get isAuthenticated {
    final String? userString = _storage.getString("user");
    return userString != null;
  }

  Future<void> saveToken(String token) async {
    await _storage.setString("token", token);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.setString("user_id", userId);
  }

  Future<void> saveUserBody(String userResponseBody) async {
    await _storage.setString("user", userResponseBody);
  }
}
