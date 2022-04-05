import 'package:get/get.dart';

import '../models/models.dart';

class ProductDetailController extends GetxController {
  Results? product;

  Map? arguements = Get.arguments != null
      ? Map<String, dynamic>.from(Get.arguments as Map<String, dynamic>)
      : null;

  int? numPages;
  int currentPage = 0;

  void formatProduct() {
    product = arguements!['product_list'] as Results?;
    numPages = product!.images!.length;
    update();
  }

  void currentPageAction(int index) {
    currentPage = index;
    update();
  }

  static ProductDetailController get action => Get.find(); // add this line

}
