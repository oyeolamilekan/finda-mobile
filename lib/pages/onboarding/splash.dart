import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive_loading/rive_loading.dart';

import '../../config/size_config.dart';
import '../../extentions/extentions.dart';
import '../../services/user/user_service.dart';
import '../../set_up.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late String initialRoute;
  final UserSerivce userSerivce = locator<UserSerivce>();

  void checkIfAuthenticated() {
    initialRoute = userSerivce.isAuthenticated ? "/index" : "/signIn";
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(initialRoute);
    });
  }

  @override
  void initState() {
    checkIfAuthenticated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 30.h,
            child: RiveLoading(
              name: 'assets/logo/logo.riv',
              loopAnimation: 'movement',
              startAnimation: 'movement',
              endAnimation: 'movement',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
              onSuccess: (_) {},
              onError: (err, stack) {},
            ),
          ),
        ),
      ),
    );
  }
}
