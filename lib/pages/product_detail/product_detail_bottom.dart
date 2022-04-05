import 'package:cached_network_image/cached_network_image.dart';
import 'package:finda/widgets/cached_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../extentions/extentions.dart';
import '../../models/product.dart';
import '../../utils/launch_url.dart';
import '../../widgets/photo_view.dart';
import 'product_wishlist.dart';

class ProductDetailBottom extends StatelessWidget {
  final Results? products;

  const ProductDetailBottom({
    Key? key,
    this.products,
  }) : super(key: key);

  void _enlarge(String imageUrl) {
    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: FINDAPhotoView(
          image: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }

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
                    Get.bottomSheet(
                      ProductWishList(
                        productId: products!.id,
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
                          FeatherIcons.shoppingBag,
                          color: Theme.of(context).textTheme.button!.color,
                          size: 4.5.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add to wishlist",
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
                                  child: InkWell(
                                    onTap: () => _enlarge(
                                      products!.images![index],
                                    ),
                                    child: STEMCachedNetworkImage(
                                      photoUrl:
                                          products!.images![index].toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: products!.images!.length,
                            scrollDirection: Axis.horizontal,
                          )
                        : SizedBox(
                            child: InkWell(
                              onTap: () => _enlarge(
                                products!.picture!,
                              ),
                              child: STEMCachedNetworkImage(
                                photoUrl: products!.picture!,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (products!.shopLogo != null)
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.toNamed(
                                "/merchantProfile",
                                arguments: {
                                  "shopName": products?.shopName ?? "",
                                  "shopLogo": products?.shopLogo ?? "",
                                  "shopBio": products?.shopBio ?? "",
                                  "shopUrl": products?.completeUrl ?? "",
                                },
                              );
                            },
                            child: Container(
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
