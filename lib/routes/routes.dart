import 'package:get/get.dart';

import '../pages/changelogs/change_logs.dart';
import '../pages/onboarding/splash.dart';
import '../pages/pages.dart';
import '../pages/product_detail/create_wishlist.dart';
import '../pages/product_detail/edit_wishlist.dart';
import '../pages/product_detail/product_wishlist_detail.dart';

final routes = [
  GetPage(
    name: '/splash',
    page: () => Splash(),
  ),
  GetPage(
    name: '/results',
    page: () => Results(),
  ),
  GetPage(
    name: '/create_wishlist',
    page: () => CreateWishList(),
  ),
  GetPage(
    name: '/wishlist_details',
    page: () => ProductWishListDetail(),
  ),
  GetPage(
    name: '/index',
    page: () => Index(),
  ),
  GetPage(
    name: '/edit_wishlist',
    page: () => EditWishList(),
  ),
  GetPage(
    name: '/resetPassword',
    page: () => ResetPassword(),
  ),
  GetPage(
    name: '/merchantProfile',
    page: () => MerchantProfile(),
  ),
  GetPage(
    name: '/change_logs',
    page: () => ChangeLogs(),
  ),
  GetPage(
    name: '/signIn',
    page: () => SignIn(),
  ),
  GetPage(
    name: '/signUp',
    page: () => SignUp(),
  ),
  GetPage(
    name: '/signOut',
    page: () => SignOut(),
  ),
];
