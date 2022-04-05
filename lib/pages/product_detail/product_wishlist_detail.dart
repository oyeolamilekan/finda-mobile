import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/wishlist/product_wishlist_detail_controller.dart';
import '../../extentions/extentions.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';
import 'product_wishlist_bottom.dart';

class ProductWishListDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    return GetBuilder<ProductWishListDetailController>(
      init: ProductWishListDetailController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.wishlistName ?? "Wishlist",
          ),
          centerTitle: true,
        ),
        body: FINDASuspense(
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
              controller.reloadWishlistProduct();
            },
          ),
          errorWidget: ErrorWidgetContainer(
            title:
                "Something is wrong somewhere, don't worry we are fixing it.",
            onReload: () {
              controller.reloadWishlistProduct();
            },
          ),
          successWidget: (_) => CustomScrollView(
            controller: controller.scrollController,
            slivers: <Widget>[
              if ((controller.products.results?.length ?? 0) > 0)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: controller.products.results!.length,
                        itemBuilder: (context, index) {
                          offset += 5;
                          time = 800 + offset;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            height: 100,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  ProductWishlistBottom(
                                    products:
                                        controller.products.results![index],
                                    wishListSlug: controller.wishlistSlug,
                                  ),
                                  isScrollControlled: true,
                                  barrierColor: Colors.black.withOpacity(
                                    0.15,
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: controller
                                    .products.results![index].picture!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: controller.products.results![index]
                                              .images!.length >
                                          1
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                            top: 9,
                                            left: 9,
                                          ),
                                          child: const Icon(
                                            FeatherIcons.grid,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.white,
                                  period: Duration(milliseconds: time),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    addRepaintBoundaries: false,
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "You currently have no product in this wishlist, try adding some.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 5.text,
                      ),
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (controller.products.next != null) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 2.h, top: 2.h),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Center(
                              child: CircleProgessBar(
                                color: Theme.of(context).cardColor,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  childCount: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
