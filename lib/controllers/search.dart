// import 'dart:convert';
// import 'dart:io' show Platform;

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../extentions/extentions.dart';
// import '../models/models.dart';
// import '../services/http/base.dart';
// import '../setUp.dart';
// import '../utils/get_action.dart';
// import '../widgets/button.dart';

// class SearchController extends GetxController {
//   final firebaseMessaging = locator<FirebaseMessaging>();
//   final sharedPrefrence = locator<SharedPreferences>();
//   final _client = locator<ApiClient>();
//   String firebaseToken;
//   var user;
//   bool isDarkMode;
//   bool isAuthenticated;
//   Map phoneInfo;
//   Map data;

//   onStartState() async {
//     getUserCredential();
//     isDarkMode = sharedPrefrence.get("isDark") ?? false;
//     phoneInfo = await initPlatformState();
//     isAuthenticated = sharedPrefrence.getBool("is_authenticated") ?? null;
//     firebaseMessaging.getToken().then((value) async {
//       Map dataPayload = {
//         'current_token': value,
//         'phone_brand': phoneInfo['model'],
//         'phone_plaform': (Platform.isAndroid
//             ? "Android"
//             : Platform.isIOS
//                 ? 'IOS'
//                 : 'Unknown'),
//         'meta_info': phoneInfo,
//       };
//       await _client.put(
//         "auth/register_phone_token_finda/",
//         dataPayload,
//         auth: isAuthenticated != null,
//       );
//     });
//     _configureFirebaseListeners();
//   }

//   getUserCredential() {
//     user = sharedPrefrence.getString("user");
//     user = user == null ? null : User.fromJson(json.decode(user));
//   }

//   _configureFirebaseListeners() {
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         if (message['data']['action'] == "UPDATE_APP") {
//           Get.dialog(
//             Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Container(
//                 height: 50.h,
//                 width: 100.w,
//                 padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       FeatherIcons.bell,
//                       size: 15.text,
//                     ),
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     Text(
//                       "We have a brand new version of our app, please kindly go to the app store and update.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 5.text),
//                     ),
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     FINDAButton(
//                       child: Text(
//                         "Download",
//                         style: Theme.of(Get.context).textTheme.button,
//                       ),
//                       color: Theme.of(Get.context).cardColor,
//                       onPressed: () => getPushAction(message['data']['action']),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else {
//           Get.snackbar(
//             message['notification']['title'],
//             message['notification']['body'],
//             snackPosition: SnackPosition.TOP,
//             colorText: Colors.white,
//             borderRadius: 5,
//             onTap: (_) => getPushAction(message['data']['action']),
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             backgroundColor: Colors.black,
//           );
//         }
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         if (message['data']['action'] == "UPDATE_APP") {
//           Get.dialog(
//             Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Container(
//                 height: 50.h,
//                 width: 100.w,
//                 padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       FeatherIcons.bell,
//                       size: 15.text,
//                     ),
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     Text(
//                       "We have a brand new version of our app, please kindly go to the app store and update.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 5.text),
//                     ),
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     FINDAButton(
//                       child: Text(
//                         "Download",
//                         style: Theme.of(Get.context).textTheme.button,
//                       ),
//                       color: Theme.of(Get.context).cardColor,
//                       onPressed: () => getPushAction(message['data']['action']),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//       onResume: (Map<String, dynamic> message) async {
//         if (message['data']['action'] == "UPDATE_APP") {
//           Get.dialog(
//             Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Container(
//                 height: 50.h,
//                 width: 100.w,
//                 padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       FeatherIcons.bell,
//                       size: 15.text,
//                     ),
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     Text(
//                       "We have a brand new version of our app, please kindly go to the app store and update.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 5.text),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     FINDAButton(
//                       child: Text(
//                         "Download",
//                         style: Theme.of(Get.context).textTheme.button,
//                       ),
//                       color: Theme.of(Get.context).cardColor,
//                       onPressed: () => getPushAction(message['data']['action']),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//     firebaseMessaging.requestNotificationPermissions(
//       const IosNotificationSettings(sound: true, badge: true, alert: true),
//     );
//   }

//   static SearchController get action => Get.find();
// }
