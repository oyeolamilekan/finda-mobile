import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../controllers/notification.dart';
import '../../extentions/extentions.dart';
import '../../models/notificaton_model.dart';
import '../../utils/date.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/suspense.dart';

class Notifications extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          return FINDASuspense(
            appState: controller.loading,
            errorWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  alignment: Alignment.center,
                  child: const Text(
                    "Something bad happened, we are currently working on it.",
                    textAlign: TextAlign.center,
                  ),
                ),
                FINDAButton(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  onPressed: () => controller.reloadNotificationAction(),
                  child: Text(
                    "Refresh page.",
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
            loadingWidget: Center(
              child: CircleProgessBar(
                color: Theme.of(context).cardColor,
                width: 40,
                height: 40,
              ),
            ),
            noInternetWidget: Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Something bad happened, kindly check your internet connection.",
                      textAlign: TextAlign.center,
                    ),
                    FINDAButton(
                      color: Theme.of(context).cardColor,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      onPressed: () => controller.reloadNotificationAction(),
                      child: Text(
                        "Refresh page.",
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  ],
                ),
              ),
            ),
            successWidget: (widget) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => controller.reloadNotificationAction(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text(
                              "Notifications",
                              style: TextStyle(
                                fontSize: 6.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: controller.notifications.results!.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  controller.notifications.results!.length,
                              controller: controller.scrollController,
                              itemBuilder: (context, index) {
                                final Results results =
                                    controller.notifications.results![index];
                                if (controller.notifications.next != null &&
                                    controller.notifications.results!.length -
                                            1 ==
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
                                  onTap: () async {
                                    Get.bottomSheet(
                                      Container(
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 40,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                                color: Colors.black.withOpacity(
                                                  0.2,
                                                ),
                                              ),
                                              child: Icon(
                                                FeatherIcons.bell,
                                                size: 8.text,
                                              ),
                                            ),
                                            Text(
                                              results.title!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 5.text,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.black
                                                        .withOpacity(
                                                      0.2,
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Icon(
                                                    FeatherIcons.calendar,
                                                    size: 3.text,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  parseDateToString(
                                                      results.created!),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            SizedBox(
                                              width: 70.w,
                                              child: Text(
                                                results.verb!,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const Spacer(),
                                            FINDAButton(
                                              color:
                                                  Theme.of(context).cardColor,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 20,
                                              ),
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                "Okay, Got it.",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      barrierColor: Colors.black.withOpacity(
                                        0.15,
                                      ),
                                    );
                                    await controller
                                        .readNotificationAction(results.id);
                                  },
                                  child: Container(
                                    width: 100.w,
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                results.title!,
                                                style: TextStyle(
                                                  fontSize: 4.text,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              if (!results.isRead!)
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          results.verb!,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                    FeatherIcons.bell,
                                    size: 8.text,
                                  ),
                                ),
                                const Text("No notifications."),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
