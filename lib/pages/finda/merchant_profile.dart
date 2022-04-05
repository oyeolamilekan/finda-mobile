import 'package:finda/controllers/merchant_profile_controller.dart';
import 'package:finda/pages/product_detail/product_detail_bottom.dart';
import 'package:finda/utils/launch_url.dart';
import 'package:finda/widgets/button.dart';
import 'package:finda/widgets/cached_image_provider.dart';
import 'package:finda/widgets/circle_progess_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finda/extentions/extentions.dart';

class MerchantProfile extends StatelessWidget {
  final GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    return GetBuilder<MerchantProfileController>(
      init: MerchantProfileController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.shopName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 1.2,
        ),
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 10),
                      child: STEMCachedNetworkImage(
                        photoUrl: controller.shopLogo,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(controller.shopBio.utf8Convert),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FINDAButton(
                            height: 40,
                            onPressed: () {
                              launchUrl(controller.shopUrl);
                            },
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: const Text(
                              "Open in instagram",
                              style: TextStyle(),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100.h,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: const Text(
                        "Products",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      child: const Text(
                        "Transactions",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isLoading)
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const CircleProgessBar(),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      key: _abcKey,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: controller.products.results?.length ?? 0,
                      itemBuilder: (context, index) {
                        offset += 5;
                        time = 800 + offset;

                        final product = controller.products.results![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          height: 100,
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                ProductDetailBottom(
                                  products: product,
                                ),
                                isScrollControlled: true,
                                barrierColor: Colors.black.withOpacity(
                                  0.15,
                                ),
                              );
                            },
                            child: STEMCachedNetworkImage(
                              photoUrl:
                                  controller.products.results![index].picture!,
                            ),
                          ),
                        );
                      },
                    ),
                    if (controller.products.next != null)
                      Container(
                        margin: EdgeInsets.only(bottom: 3.h),
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
                      ),
                  ],
                  addRepaintBoundaries: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
