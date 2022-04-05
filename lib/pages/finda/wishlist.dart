import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../extentions/extentions.dart';
import '../../models/wish_list_model.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';

class WishList extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GetBuilder<WishListController>(
        init: WishListController(),
        builder: (controller) => FINDASuspense(
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
              controller.reloadWishlist();
            },
          ),
          errorWidget: ErrorWidgetContainer(
            title:
                "Something is wrong somewhere, don't worry we are fixing it.",
            onReload: () {
              controller.reloadWishlist();
            },
          ),
          successWidget: (_) => RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => controller.reloadWishlist(),
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Wishlist.",
                            style: TextStyle(
                              fontSize: 6.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed("/create_wishlist")!.then(
                              (dynamic value) {
                                if (value != null) {
                                  controller.addNewWishList(
                                    value as Map<String, dynamic>,
                                  );
                                  FindaStyles.successSnackbar(
                                    "Wishlist",
                                    "You have successfully created a wishlist",
                                  );
                                }
                              },
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(FeatherIcons.plus),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: controller.wishList.results!.isNotEmpty
                        ? ListView.builder(
                            controller: controller.wishlistScrollController,
                            itemCount: controller.wishList.results!.length,
                            itemBuilder: (context, index) {
                              final WishlistResults wishlist =
                                  controller.wishList.results![index];
                              if (controller.wishList.next != null &&
                                  controller.wishList.results!.length - 1 ==
                                      index) {
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Center(
                                    child: CircleProgessBar(
                                      color: Theme.of(context).cardColor,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                );
                              }
                              return InkWell(
                                onLongPress: () {
                                  Get.bottomSheet(
                                    Container(
                                      height: 15.h,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 13,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();

                                                Get.toNamed(
                                                  "/edit_wishlist",
                                                  arguments: {
                                                    "slug": wishlist.slug,
                                                  },
                                                )!
                                                    .then(
                                                  (dynamic value) => controller
                                                      .updateWishlistAction(
                                                    value
                                                        as Map<String, dynamic>,
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(FeatherIcons.edit),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Edit Wishlist")
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                                Get.dialog(
                                                  StatefulBuilder(
                                                    builder: (context,
                                                            setState) =>
                                                        GetBuilder<
                                                            WishListController>(
                                                      init:
                                                          WishListController(),
                                                      builder: (controller) =>
                                                          Dialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: Container(
                                                          height: 300,
                                                          width: 100.w,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 2.h,
                                                                  horizontal:
                                                                      4.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                FeatherIcons
                                                                    .alertOctagon,
                                                                size: 15.text,
                                                              ),
                                                              SizedBox(
                                                                height: 3.h,
                                                              ),
                                                              Text(
                                                                "Are you sure you want to delete this wishlist.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      4.5.text,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        FINDAButton(
                                                                      color: controller.btnLoading ==
                                                                              AppState
                                                                                  .loading
                                                                          ? Theme.of(context)
                                                                              .cardColor
                                                                              .withOpacity(0.5)
                                                                          : Theme.of(context).cardColor,
                                                                      onPressed:
                                                                          () async {
                                                                        await controller
                                                                            .deleteWishlistAction(
                                                                          wishlist
                                                                              .slug,
                                                                        );
                                                                        Get.back();
                                                                      },
                                                                      child: controller.btnLoading ==
                                                                              AppState.loading
                                                                          ? const CircleProgessBar(color: Colors.white)
                                                                          : Text(
                                                                              "Yes",
                                                                              style: Theme.of(context).textTheme.button,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        FINDAOutlineButton(
                                                                      color: Theme
                                                                          .of(
                                                                        context,
                                                                      ).cardColor,
                                                                      onPressed: () => controller.btnLoading !=
                                                                              AppState.loading
                                                                          ? Get.back()
                                                                          : () {},
                                                                      child:
                                                                          const Text(
                                                                        "No.",
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(FeatherIcons.trash),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Delete Wishlist")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                onTap: () {
                                  Get.toNamed(
                                    "/wishlist_details",
                                    arguments: {
                                      "name": wishlist.title,
                                      "slug": wishlist.slug,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:
                                            const Icon(FeatherIcons.bookmark),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            wishlist.title!.utf8Convert,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 4.5.text,
                                            ),
                                          ),
                                          Text(
                                            "created: ${wishlist.created!.turnStringToDate(
                                              'MMMM dd, yyyy.',
                                            )}",
                                            style: TextStyle(
                                              fontSize: 3.4.text,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
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
        ),
      ),
    );
  }
}
