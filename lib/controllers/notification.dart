import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/loading_const.dart';
import '../const/styles.dart';
import '../exception/http_exception.dart';
import '../exception/utils.dart';
import '../models/notificaton_model.dart';
import '../network/notification.dart';
import '../set_up.dart';

class NotificationController extends GetxController {
  AppState loading = AppState.loading;
  AppState nextLoading = AppState.none;
  late Notifications notifications;
  final NotificationService? notification = locator<NotificationService>();
  final scrollController = ScrollController();
  final SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  Map<String, dynamic>? data;

  @override
  Future<void> onInit() async {
    scrollController.addListener(_onScroll);
    Future.delayed(const Duration(seconds: 2), () {});
    await notificationAction();
    super.onInit();
  }

  Future<void> notificationAction() async {
    try {
      final response = await notification!.notifications();
      data = json.decode(response.body) as Map<String, dynamic>?;
      notifications = Notifications.fromJson(data);
      loading = AppState.none;
    } on FetchDataException {
      loading = AppState.none;
      FindaStyles.errorSnackBar(
        null,
        "Something is wrong with the server, don't worry we are fixing it.",
      );
    } catch (e) {
      loading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }

  Future<void> readNotificationAction(String? id) async {
    try {
      final response = await notification!.readNotification(id);
      data = json.decode(response.body.isEmpty ? "{}" : response.body)
          as Map<String, dynamic>?;
      notifications.results = notifications.results!.map(
        (notification) {
          if (notification.id == id) {
            notification.isRead = true;
          }
          return notification;
        },
      ).toList();
    } catch (e) {
      loading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }

  Future<void> loadNextNotificationAction() async {
    try {
      final response = await notification!.loadNextNotification(
        notifications.next!,
      );
      final nextData = Notifications.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      notifications.results = [...notifications.results!, ...nextData.results!];
      notifications.next = nextData.next;
    } catch (e) {
      loading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
    }
    update();
  }

  Future<void> reloadNotificationAction() async {
    loading = AppState.loading;
    update();
    await notificationAction();
  }

  Future<void> _onScroll() async {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      if (notifications.next != null && nextLoading != AppState.loading) {
        nextLoading = AppState.loading;
        update();
        await loadNextNotificationAction();
        nextLoading = AppState.none;
        update();
      }
    }
  }
}
