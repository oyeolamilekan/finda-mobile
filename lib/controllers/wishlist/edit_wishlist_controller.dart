import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/wish_list_model.dart';
import '../../network/products.dart';
import '../../set_up.dart';

class EditWishListController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  AppState loadingState = AppState.loading;
  AppState btnLoadingState = AppState.none;
  bool? isPrivate = false;
  final ProductService? productService = locator<ProductService>();
  Map? arguements = Get.arguments != null
      ? Map<String, dynamic>.from(Get.arguments as Map<String, dynamic>)
      : null;
  late WishlistResults wishlistResults;

  void togglePrivate() {
    isPrivate = !isPrivate!;
    update();
  }

  Future<void> getWishlistDetail() async {
    try {
      final data = await productService!.getWishlistDetail(
        arguements!['slug'] as String?,
      );
      final Map<String, dynamic> encodedData =
          json.decode(data.body) as Map<String, dynamic>;
      wishlistResults = WishlistResults.fromJson(encodedData);
      titleController.text = wishlistResults.title!;
      descriptionController.text = wishlistResults.description!;
      isPrivate = wishlistResults.isPrivate;
      loadingState = AppState.none;
    } catch (e) {
      loadingState = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }

  Future<void> reloadWishlistDetail() async {}

  Future<void> editWishlistAction() async {
    try {
      btnLoadingState = AppState.loading;
      update();
      final data = await productService!.editWishlist(
        titleController.text,
        descriptionController.text,
        arguements!['slug'] as String?,
        isPrivate: isPrivate,
      );
      btnLoadingState = AppState.none;
      Get.back(result: json.decode(data.body));
    } catch (e) {
      loadingState = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(null, message);
    }
    update();
  }

  @override
  void onInit() {
    getWishlistDetail();
    super.onInit();
  }
}
