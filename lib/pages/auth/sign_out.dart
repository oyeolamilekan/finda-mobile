import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extentions/num.dart';
import '../../set_up.dart';
import '../../widgets/button.dart';

class SignOut extends StatelessWidget {
  final SharedPreferences? sharedPreferences = locator<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Log out",
              style: TextStyle(
                fontSize: 7.text,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text("Are you sure, you want to log out."),
            SizedBox(
              height: 2.h,
            ),
            FINDAButton(
              width: 60.w,
              color: Theme.of(context).cardColor,
              onPressed: () async {
                await sharedPreferences!.remove("is_authenticated");
                Get.offAllNamed("/signIn");
              },
              child: Text(
                "Logout",
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
