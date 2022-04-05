import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../extentions/extentions.dart';
import '../../models/wish_list_model.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';

class ProductWishList extends StatelessWidget {
  final String? productId;

  const ProductWishList({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(
      tag: "productWishlist",
      init: WishListController(),
      initState: (_) => WishListController.action.getWishList(),
      builder: (controller) => Container(
        width: 100.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: FINDASuspense(
          appState: controller.loading,
          loadingWidget: Center(
            child: CircleProgessBar(
              color: Theme.of(context).cardColor,
              width: 40,
              height: 40,
            ),
          ),
          noInternetWidget: ErrorWidgetContainer(
            onReload: () {
              controller.getWishList();
            },
          ),
          errorWidget: ErrorWidgetContainer(
            title:
                "Something is wrong somewhere, don't worry we are fixing it.",
            onReload: () {
              controller.getWishList();
            },
          ),
          successWidget: (_) => Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.5),
                      width: 0.2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (controller.btnLoading != AppState.loading) {
                          await controller.addProductToWishlist(productId);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.wishlistId != null &&
                                  controller.btnLoading != AppState.loading
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          controller.btnLoading == AppState.loading
                              ? "Adding"
                              : "Add",
                          style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: 3.5.text,
                              ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: controller.wishList.results!.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.wishList.results!.length,
                        itemBuilder: (context, index) {
                          final WishlistResults wishlist =
                              controller.wishList.results![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: InkWell(
                              onTap: () =>
                                  controller.addWishListId(wishlist.slug),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(FeatherIcons.bookmark),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        wishlist.title!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Products: ${wishlist.productCount.toString()}",
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  if (controller.checkIfChoosen(wishlist.slug))
                                    const Icon(FeatherIcons.check)
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                              color: Colors.black.withOpacity(
                                0.2,
                              ),
                            ),
                            child: Icon(
                              FeatherIcons.bookmark,
                              size: 8.text,
                            ),
                          ),
                          const Text("Your wishlist is not emtpty."),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
