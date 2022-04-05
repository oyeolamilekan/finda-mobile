import 'dart:convert';

import 'package:finda/const/styles.dart';
import 'package:finda/exception/utils.dart';
import 'package:finda/models/models.dart';
import 'package:finda/network/products.dart';
import 'package:finda/set_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/loading_const.dart';
import 'package:finda/extentions/string.dart';

class MerchantProfileController extends GetxController {
  AppState nextLoading = AppState.none;

  AppState appState = AppState.loading;

  Map<String, dynamic> arguements = Get.arguments as Map<String, dynamic>;

  final ProductService _productService = locator<ProductService>();

  late String shopName;

  late String shopLogo;

  late String shopBio;

  late String shopUrl;

  late Products products;

  final scrollController = ScrollController();

  bool get isLoading => appState == AppState.loading;

  Future<void> fetchProductService() async {
    try {
      final response = await _productService.fetchMerchantProduct(shopName);
      final decodedBody = json.decode(response.body);
      products = Products.fromJson(decodedBody);
      appState = AppState.none;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message.utf8Convert,
        position: SnackPosition.TOP,
      );
      appState = AppState.error;
    }
    update();
  }

  Future<void> loadNextProductsAction() async {
    try {
      final response = await _productService.loadNextProducts(products.next!);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final nextData = Products.fromJson(responseData);
      products.results = [...products.results!, ...nextData.results!];
      products.next = nextData.next;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message.utf8Convert,
        position: SnackPosition.TOP,
      );
      appState = AppState.error;
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

  MerchantProfileController() {
    shopName = arguements['shopName'] as String;
    shopLogo = arguements['shopLogo'] as String;
    shopBio = arguements['shopBio'] as String;
    shopUrl = arguements['shopUrl'] as String;
  }

  @override
  void onInit() {
    fetchProductService();
    scrollController.addListener(_onScroll);
    super.onInit();
  }
}
