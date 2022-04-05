import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/size_config.dart';
import '../../controllers/products/results.dart';
import '../../extentions/num.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/logo.dart';
import '../../widgets/suspense.dart';
import '../../widgets/text_field.dart';
import '../product_detail/product_detail_bottom.dart';

class Results extends StatelessWidget {
  final ResultsController detailController = Get.put(ResultsController());
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int offset = 0;
    int time = 800;
    return GetBuilder<ResultsController>(
      init: ResultsController(),
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
            controller.reloadProducts();
          },
        ),
        errorWidget: ErrorWidgetContainer(
          title: "Something is wrong somewhere, don't worry we are fixing it.",
          onReload: () {
            controller.reloadProducts();
          },
        ),
        successWidget: (_) => CustomScrollView(
          controller: controller.scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              centerTitle: true,
              toolbarHeight: 60.0,
              expandedHeight: 30,
              title: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: SizedBox(
                        height: 5.h,
                        child: Logo(),
                      ),
                    ),
                    Flexible(
                      child: FINDATextFormField(
                        textEditingController: textEditingController,
                        suffixIcon: FeatherIcons.search,
                        inputAction: TextInputAction.search,
                        suffixOnClick: () {
                          controller.getProducts(
                            term: textEditingController.text,
                          );
                        },
                        onEditingComplete: () {
                          controller.getProducts(
                            term: textEditingController.text,
                          );
                        },
                        isBoarder: false,
                        labelText: "Search products, eg iphone, samsung e.t.c",
                      ),
                    ),
                  ],
                ),
              ),
              titleSpacing: 0,
              elevation: 1.0,
            ),
            if ((controller.products.results?.length ?? 0) > 1)
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
                      itemCount: controller.products.results!.length,
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  controller.products.results![index].picture!,
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
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: CachedNetworkImage(
                                    imageUrl: product.shopLogo!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 3.0,
                                            color: Colors.lightBlue),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
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
                    "No product matches your query, please try another term.",
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
                      margin: EdgeInsets.only(bottom: 10.h),
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
    );
  }
}
