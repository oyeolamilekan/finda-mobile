import 'dart:convert';

import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../network/products.dart';
import '../../set_up.dart';

class CreateWishListController extends GetxController {
  AppState loadingState = AppState.none;
  bool isPrivate = false;
  final ProductService? productService = locator<ProductService>();

  void togglePrivate() {
    isPrivate = !isPrivate;
    update();
  }

  Future<void> createWishlistAction(String title, String description) async {
    try {
      loadingState = AppState.loading;
      update();
      final data = await productService!.createWishlist(
        title,
        description,
        isPrivate: isPrivate,
      );
      loadingState = AppState.none;
      Get.back(result: json.decode(data.body));
    } catch (e) {
      loadingState = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }
}
