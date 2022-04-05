import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const/user_conts.dart';
import '../models/models.dart';
import '../set_up.dart';

class NotificationService {
  final SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<http.Response> notifications() async {
    final String user = sharedPreferences!.getString("user")!;
    final User userModel = User.fromJson(
      json.decode(user) as Map<String, dynamic>,
    );
    headers['Authorization'] = "Bearer ${userModel.token}";
    final http.Response response = await http.get(
      Uri.parse('$authUrl/notifications/finda_notification/'),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> readNotification(String? id) async {
    final String user = sharedPreferences!.getString("user")!;
    final User userModel = User.fromJson(
      json.decode(user) as Map<String, dynamic>,
    );
    headers['Authorization'] = "Bearer ${userModel.token}";
    final http.Response response = await http.put(
      Uri.parse('$authUrl/notifications/finda_details/$id/'),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> loadNextNotification(String nextUrl) async {
    final String user = sharedPreferences!.getString("user")!;
    final User userModel = User.fromJson(
      json.decode(user) as Map<String, dynamic>,
    );
    headers['Authorization'] = "Bearer ${userModel.token}";
    final http.Response response = await http.get(
      Uri.parse(nextUrl),
      headers: headers,
    );
    return response;
  }
}
