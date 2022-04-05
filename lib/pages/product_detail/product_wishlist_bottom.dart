import 'package:finda/widgets/cached_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../controllers/wishlist/product_wishlist_detail_controller.dart';
import '../../extentions/extentions.dart';
import '../../models/product.dart';
import '../../utils/launch_url.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';

class ProductWishlistBottom extends StatelessWidget {
  final Results? products;
  final String? wishListSlug;

  const ProductWishlistBottom({
    Key? key,
    this.products,
    this.wishListSlug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return Container(
      height: 100.h,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(FeatherIcons.x),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      StatefulBuilder(
                        builder: (context, setState) =>
                            GetBuilder<ProductWishListDetailController>(
                          init: ProductWishListDetailController(),
                          builder: (controller) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              height: 300,
                              width: 100.w,
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 4.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FeatherIcons.alertOctagon,
                                    size: 15.text,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    "Are you sure you want to delete this product from wishlist.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 4.text),
                                  ),
                                  SizedBox(
                                    height: 4.5.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FINDAButton(
                                          color: controller.btnLoading ==
                                                  AppState.loading
                                              ? Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.5)
                                              : Theme.of(context).cardColor,
                                          onPressed: () async {
                                            await controller
                                                .deleteProductWishlist(
                                              products!.id,
                                              wishListSlug,
                                            );
                                            Get.back();
                                            Get.back();
                                          },
                                          child: controller.btnLoading ==
                                                  AppState.loading
                                              ? const CircleProgessBar(
                                                  color: Colors.white)
                                              : Text(
                                                  "Yes",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: FINDAOutlineButton(
                                          color: Theme.of(
                                            context,
                                          ).cardColor,
                                          onPressed: () =>
                                              controller.btnLoading !=
                                                      AppState.loading
                                                  ? Get.back()
                                                  : () {},
                                          child: const Text(
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
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.trash,
                          color: Theme.of(context).textTheme.button!.color,
                          size: 4.5.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Remove product",
                          style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: 3.5.text,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
              child: ListView(
                children: [
                  SizedBox(
                    height: 40.h,
                    child: products!.images!.length > 1
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              offset += 5;
                              time = 800 + offset;
                              return SizedBox(
                                child: Container(
                                  width: 100.w,
                                  margin: EdgeInsets.only(left: 2.w),
                                  child: STEMCachedNetworkImage(
                                    photoUrl:
                                        products!.images![index].toString(),
                                  ),
                                ),
                              );
                            },
                            itemCount: products!.images!.length,
                            scrollDirection: Axis.horizontal,
                          )
                        : SizedBox(
                            child: STEMCachedNetworkImage(
                              photoUrl: products!.picture!,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.only(right: 10),
                                child: STEMCachedNetworkImage(
                                  photoUrl: products!.shopLogo!,
                                ),
                              ),
                              Text(
                                products!.shopName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          products!.title!.utf8Convert,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 3.5.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      launchUrl(products!.completeUrl!);
                    },
                    child: Container(
                      height: 50,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Open in Instagram",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  fontSize: 3.5.text,
                                ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            FeatherIcons.instagram,
                            color: Theme.of(context).textTheme.button!.color,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.bottomSheet(
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                alignment: Alignment.center,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Contact",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (products!.shopPhoneNumber!.isNotEmpty)
                                ContactContainer(
                                  title: "Call",
                                  content: products!.shopPhoneNumber,
                                  action: () => launchUrl(
                                    "tel://${products!.shopPhoneNumber}",
                                  ),
                                ),
                              if (products!.shopEmail!.isNotEmpty)
                                ContactContainer(
                                  title: "Email",
                                  content: products!.shopEmail,
                                  action: () => launchUrl(
                                    "mailto:${products!.shopEmail}",
                                  ),
                                ),
                              ContactContainer(
                                title: "DM Vendor",
                                content:
                                    "Send a message to ${products!.shopName}",
                                action: () => launchUrl(products!.shopUrl!),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SizedBox(
                              child: Text(
                                "Contact Vendor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 3.5.text,
                                ),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            FeatherIcons.send,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactContainer extends StatelessWidget {
  final String? title;
  final String? content;
  final VoidCallback? action;
  const ContactContainer({
    Key? key,
    this.title,
    this.content,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(vertical: 1.h),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(content!),
          ],
        ),
      ),
    );
  }
}
