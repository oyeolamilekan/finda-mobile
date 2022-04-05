import 'package:http/http.dart' as http;

import '../services/http/base.dart';
import '../services/http/constants.dart' as api_constants;
import '../set_up.dart';

class ProductService {
  final ApiClient _apiClient = locator<ApiClient>();

  Future<http.Response> searchQuery(String value) async {
    final http.Response response = await _apiClient.get(
      "instashop/products_list_view/?q=$value",
      auth: true,
    );
    return response;
  }

  Future<http.Response> loadNextProducts(String nextUrl) async {
    final url = nextUrl.replaceAll(api_constants.baseUrL, "");
    final http.Response response = await _apiClient.get(
      url,
      auth: true,
    );
    return response;
  }

  Future<http.Response> createWishlist(String title, String description,
      {bool isPrivate = false}) async {
    final Map<String, dynamic> data = {
      "title": title,
      "description": description,
      "isPrivate": isPrivate,
    };
    final http.Response response = await _apiClient.post(
      "instashop/wish_list/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> editWishlist(
      String title, String description, String? slug,
      {bool? isPrivate = false}) async {
    final Map<String, dynamic> data = {
      "title": title,
      "description": description,
      "isPrivate": isPrivate,
    };
    final http.Response response = await _apiClient.put(
      "instashop/wish_list/$slug/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> getWishlist() async {
    final http.Response response = await _apiClient.get(
      "instashop/wish_list/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> addProductToWishlist(
    String? slug,
    String? productID,
  ) async {
    final Map<String, dynamic> data = {
      "product_id": productID,
    };
    final http.Response response = await _apiClient.post(
      "instashop/wish_list_products/$slug/",
      data,
      auth: true,
    );
    return response;
  }

  Future<http.Response> loadNextWishlist(String nextUrl) async {
    final url = nextUrl.replaceAll(api_constants.baseUrL, "");
    final http.Response response = await _apiClient.get(
      url,
      auth: true,
    );
    return response;
  }

  Future<http.Response> deleteWishlist(String? slug) async {
    final http.Response response = await _apiClient.delete(
      "instashop/wish_list/$slug/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> getWishlistDetail(String? slug) async {
    final http.Response response = await _apiClient.get(
      "instashop/wish_list/$slug/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> getWishlistProducts(String? slug) async {
    final http.Response response = await _apiClient.get(
      "instashop/wish_list_products/$slug/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> deleteWishlistProduct(
    String? productId,
    String? slug,
  ) async {
    final http.Response response = await _apiClient.delete(
      "instashop/delete_wishlist_product/$productId/$slug/",
      auth: true,
    );
    return response;
  }

  Future<http.Response> fetchMerchantProduct(String merchantName) async {
    final http.Response response = await _apiClient.get(
      "instashop/merchant_products/$merchantName/",
      auth: true,
    );
    return response;
  }
}
