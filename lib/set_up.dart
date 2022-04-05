import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/auth.dart';
import 'network/notification.dart';
import 'network/products.dart';
import 'services/http/base.dart';
import 'services/pushnotification/pushnotification.dart';
import 'services/storage/index.dart';
import 'services/user/user_service.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();

  final instance = await SharedPreferences.getInstance();

  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  PushNotification.registerToken();
  locator.registerLazySingleton<Storage>(() => Storage());
  locator.registerLazySingleton<UserSerivce>(() => UserSerivce());
  locator
      .registerLazySingleton<NotificationService>(() => NotificationService());
  locator.registerLazySingleton<ProductService>(() => ProductService());
  locator.registerLazySingleton<Authenication>(() => Authenication());
  locator.registerLazySingleton<ImagePicker>(() => ImagePicker());
  locator.registerLazySingleton<SharedPreferences>(() => instance);
  locator.registerLazySingleton<FirebaseMessaging>(
      () => FirebaseMessaging.instance);
}
