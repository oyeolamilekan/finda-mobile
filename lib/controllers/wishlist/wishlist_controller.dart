import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../exception/utils.dart';
import '../../models/wish_list_model.dart';
import '../../network/products.dart';
import '../../set_up.dart';

class WishListController extends GetxController {
  final ProductService? wishlist = locator<ProductService>();
  String? wishlistId;

  AppState loading = AppState.loading;
  AppState btnLoading = AppState.none;
  AppState nextLoading = AppState.none;
  Map<String, dynamic>? results;
  late WishList wishList;

  final wishlistScrollController = ScrollController();

  Future<void> getWishList() async {
    try {
      final data = await wishlist!.getWishlist();
      results = json.decode(data.body) as Map<String, dynamic>?;
      wishList = WishList.fromJson(results);
      loading = AppState.none;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      loading = AppState.error;
    }
    update();
  }

  Future<void> addProductToWishlist(String? productId) async {
    try {
      btnLoading = AppState.loading;
      update();
      await wishlist!.addProductToWishlist(
        wishlistId,
        productId,
      );
      update();
      Get.back();
      FindaStyles.successSnackbar(
        null,
        "Product has been successfully added to your wishlist",
      );
      btnLoading = AppState.none;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      btnLoading = AppState.error;
    }
    update();
  }

  void addWishListId(String? wishListId) {
    wishlistId = wishListId;
    update();
  }

  bool checkIfChoosen(String? wishListId) {
    return wishListId == wishlistId;
  }

  void addNewWishList(Map<String, dynamic> data) {
    final WishlistResults wishlistObj = WishlistResults.fromJson(data);
    wishList.results = [wishlistObj, ...wishList.results!];
    update();
  }

  Future<void> loadnextWishlist() async {
    try {
      final response = await wishlist!.loadNextWishlist(
        wishList.next!,
      );
      final nextData =
          WishList.fromJson(json.decode(response.body) as Map<String, dynamic>);
      wishList.results = [...wishList.results!, ...nextData.results!];
      wishList.next = nextData.next;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
    }
    update();
  }

  Future<void> _onScroll() async {
    if (wishlistScrollController.position.maxScrollExtent ==
        wishlistScrollController.position.pixels) {
      if (wishList.next != null && nextLoading != AppState.loading) {
        nextLoading = AppState.loading;
        update();
        await loadnextWishlist();
        nextLoading = AppState.none;
        update();
      }
    }
  }

  Future<void> updateWishlistAction(Map<String, dynamic> data) async {
    final WishlistResults wishlistObj = WishlistResults.fromJson(data);
    wishList.results![wishList.results!
        .indexWhere((element) => element.id == wishlistObj.id)] = wishlistObj;
    update();
  }

  Future<void> deleteWishlistAction(String? slug) async {
    try {
      btnLoading = AppState.loading;
      update();
      await wishlist!.deleteWishlist(
        slug,
      );
      wishList.results = wishList.results!.where((value) {
        return value.slug != slug;
      }).toList();
      btnLoading = AppState.none;
    } catch (e) {
      btnLoading = AppState.error;
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
    }
    update();
  }

  Future<void> reloadWishlist() async {
    try {
      loading = AppState.loading;
      update();
      await getWishList();
      loading = AppState.none;
    } catch (e) {
      final String message =
          await ApiError.convertExceptionToString(e as Exception);
      FindaStyles.errorSnackBar(
        null,
        message,
      );
      loading = AppState.error;
    }
    update();
  }

  @override
  Future<void> onInit() async {
    await getWishList();
    wishlistScrollController.addListener(_onScroll);
    super.onInit();
  }

  static WishListController get action => Get.find();
}
