import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../exception/utils.dart';
import '../../models/models.dart';
import '../../set_up.dart';
import '../storage/index.dart';
import 'constants.dart' as api_constants;

class ApiClient {
  Storage? storage = locator<Storage>();

  Future<http.Response> get(String url, {bool auth = false}) async {
    Map<String, String> headers = {};
    final String? value = storage!.getString("user");
    if (auth && value != null) {
      final User userModel = User.fromJson(
        json.decode(value) as Map<String, dynamic>,
      );
      headers = {
        ...api_constants.headers,
        HttpHeaders.authorizationHeader: "Bearer ${userModel.token}",
      };
    } else {
      headers = {
        ...api_constants.headers,
      };

      headers.remove(HttpHeaders.authorizationHeader);
    }
    final response = await http.get(
      Uri.parse("${api_constants.baseUrL}$url"),
      headers: headers,
    );
    ApiError.checkResponse(response.statusCode);
    return response;
  }

  Future<http.Response> post(String url, Map body, {bool auth = false}) async {
    Map<String, String> headers = {};
    final String? value = storage!.getString("user");
    if (auth && value != null) {
      final User userModel = User.fromJson(
        json.decode(value) as Map<String, dynamic>,
      );
      headers = {
        ...api_constants.headers,
        HttpHeaders.authorizationHeader: "Bearer ${userModel.token}",
      };
    } else {
      headers = {
        ...api_constants.headers,
      };

      headers.remove(HttpHeaders.authorizationHeader);
    }
    final response = await http.post(
      Uri.parse("${api_constants.baseUrL}$url"),
      body: json.encode(body),
      headers: headers,
    );
    ApiError.checkResponse(response.statusCode);
    return response;
  }

  Future<http.Response> put(String url, Map body, {bool auth = false}) async {
    Map<String, String> headers = {};
    final String? value = storage!.getString("user");
    if (auth && value != null) {
      final User userModel = User.fromJson(
        json.decode(value) as Map<String, dynamic>,
      );
      headers = {
        ...api_constants.headers,
        HttpHeaders.authorizationHeader: "Bearer ${userModel.token}",
      };
    } else {
      headers = {
        ...api_constants.headers,
      };

      headers.remove(HttpHeaders.authorizationHeader);
    }
    final response = await http.put(
      Uri.parse("${api_constants.baseUrL}$url"),
      body: json.encode(body),
      headers: headers,
    );
    ApiError.checkResponse(response.statusCode);
    return response;
  }

  Future<http.Response> delete(String url, {bool auth = false}) async {
    Map<String, String> headers = {};
    final String? value = storage!.getString("user");
    if (auth && value != null) {
      final User userModel = User.fromJson(
        json.decode(value) as Map<String, dynamic>,
      );
      headers = {
        ...api_constants.headers,
        HttpHeaders.authorizationHeader: "Bearer ${userModel.token}",
      };
    } else {
      headers = {
        ...api_constants.headers,
      };

      headers.remove(HttpHeaders.authorizationHeader);
    }
    final response = await http.delete(
      Uri.parse("${api_constants.baseUrL}$url"),
      headers: headers,
    );
    ApiError.checkResponse(response.statusCode);
    return response;
  }
}
