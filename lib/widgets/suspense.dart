import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/loading_const.dart';
import '../extentions/extentions.dart';
import '../set_up.dart';
import 'button.dart';

class FINDASuspense extends StatelessWidget {
  final AppState? appState;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? noInternetWidget;
  final Widget? noAuthWidget;
  final Widget Function(BuildContext widget)? successWidget;
  final SharedPreferences? sharedPrefrence = locator<SharedPreferences>();

  FINDASuspense({
    Key? key,
    this.appState,
    this.errorWidget,
    this.successWidget,
    this.loadingWidget,
    this.noInternetWidget,
    this.noAuthWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (appState == AppState.none) {
      return successWidget!(context);
    } else if (appState == AppState.noInternet) {
      return noInternetWidget!;
    } else if (appState == AppState.noAuth) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            child: const Text(
              "Shot, your session has expired.",
              textAlign: TextAlign.center,
            ),
          ),
          FINDAButton(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            onPressed: () async {
              await sharedPrefrence!.remove("is_authenticated");
              Get.offAllNamed('/signIn');
            },
            child: Text(
              "Login",
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      );
    } else if (appState == AppState.loading) {
      return loadingWidget!;
    } else {
      return errorWidget!;
    }
  }
}
