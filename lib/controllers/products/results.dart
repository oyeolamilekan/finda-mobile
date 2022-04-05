import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/models.dart';
import '../../network/products.dart';
import '../../set_up.dart';
import 'package:finda/extentions/extentions.dart';

class ResultsController extends GetxController {
  ProductService? productService = locator<ProductService>();
  SharedPreferences? sharedPreferences = locator<SharedPreferences>();
  AppState loading = AppState.loading;
  AppState nextLoading = AppState.none;
  late Products products;
  String? message;
  Map<String, dynamic>? data;
  final scrollController = ScrollController();

  Map? arguements = Get.arguments != null
      ? Map<String, dynamic>.from(Get.arguments as Map<String, dynamic>)
      : null;

  Future<void> getProducts({String term = ''}) async {
    try {
      loading = AppState.loading;
      update();
      final response = await productService!.searchQuery(term);
      data = json.decode(response.body) as Map<String, dynamic>?;
      products = Products.fromJson(data);
      loading = AppState.none;
    } catch (e) {
      message = await ApiError.convertExceptionToString(e as Exception);
      loading = AppState.error;
    }
    update();
  }

  Future<void> loadNextProductsAction() async {
    try {
      final response = await productService!.loadNextProducts(products.next!);
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

  Future<void> reloadProducts() async {
    await getProducts();
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
  void onInit() {
    getProducts();
    scrollController.addListener(_onScroll);
    super.onInit();
  }
}
