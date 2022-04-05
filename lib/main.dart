import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiredash/wiredash.dart';
import 'extentions/extentions.dart';
import 'const/styles.dart';
import 'routes/routes.dart';
import 'set_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkMode;
  final SharedPreferences? sharedPrefrence = locator<SharedPreferences>();
  String? initialRoute;

  @override
  void initState() {
    isDarkMode = sharedPrefrence!.getBool("isDark") ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "finda-tujf0hr",
      secret: "mxgtg1z9args4fg97m140rwh4l33xuq2kva4j9zrkjn40ixf",
      navigatorKey: Get.key,
      child: GetMaterialApp(
        title: 'Finda',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: isDarkMode ? hexToColor("#222222") : Colors.white,
          disabledColor: Colors.grey,
          textTheme: TextTheme(
            button: TextStyle(
              color: isDarkMode ? hexToColor("#222222") : Colors.white,
            ),
          ),
          iconTheme: isDarkMode
              ? const IconThemeData(color: Colors.white)
              : IconThemeData(color: hexToColor("#121212")),
          cardColor: isDarkMode ? Colors.white : hexToColor("#222222"),
          canvasColor: isDarkMode ? hexToColor("#222222") : Colors.white,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          indicatorColor: isDarkMode ? Colors.white : hexToColor("#222222"),
          appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 5.text,
              )),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: hexToColor("#222222")),
        ),
        initialRoute: "/splash",
        getPages: routes,
      ),
    );
  }
}
