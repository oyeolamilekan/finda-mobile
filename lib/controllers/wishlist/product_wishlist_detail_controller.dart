import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../extentions/extentions.dart';
import '../../models/product.dart';
import '../../network/products.dart';
import '../../set_up.dart';

class ProductWishListDetailController extends GetxController {
  AppState loading = AppState.loading;
  AppState btnLoading = AppState.none;
  final scrollController = ScrollController();
  static final Map<String, dynamic>? arguements = Get.arguments != null
      ? Map<String, dynamic>.from(
          Get.arguments as Map<String, dynamic>,
        )
      : null;

  final String? wishlistSlug = arguements!['slug'] as String;
  final String? wishlistName = arguements!['name'] as String;

  final ProductService productService = locator<ProductService>();
  AppState nextLoading = AppState.none;
  Map<String, dynamic>? data;
  late Products products;
  String? message;

  Future<void> getWishlistProduct() async {
    try {
      final response = await productService.getWishlistProducts(
        wishlistSlug,
      );
      data = json.decode(response.body) as Map<String, dynamic>?;
      products = Products.fromJson(data);
      loading = AppState.none;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message!.utf8Convert,
        position: SnackPosition.TOP,
      );
      loading = AppState.error;
    }
    update();
  }

  Future<void> deleteProductWishlist(
    String? productId,
    String? wishlistSlug,
  ) async {
    try {
      btnLoading = AppState.loading;
      update();
      await productService.deleteWishlistProduct(
        productId,
        wishlistSlug,
      );
      products.results = products.results!.where((value) {
        return value.id != productId;
      }).toList();
      btnLoading = AppState.none;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message!.utf8Convert,
        position: SnackPosition.TOP,
      );
      btnLoading = AppState.error;
    }
    update();
  }

  Future<void> reloadWishlistProduct() async {}

  Future<void> loadNextProductsAction() async {
    try {
      final response = await productService.loadNextProducts(products.next!);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final nextData = Products.fromJson(responseData);
      products.results = [...products.results!, ...nextData.results!];
      products.next = nextData.next;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message!.utf8Convert,
        position: SnackPosition.TOP,
      );
      loading = AppState.error;
    }
    update();
  }

  Future<void> _onScroll() async {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      if (products.next != null && nextLoading != AppState.loading) {
        nextLoading = AppState.loading;
        update();
        await loadNextProductsAction();
        nextLoading = AppState.none;
        update();
      }
    }
  }

  @override
  Future<void> onInit() async {
    await getWishlistProduct();
    scrollController.addListener(_onScroll);
    super.onInit();
  }
}
