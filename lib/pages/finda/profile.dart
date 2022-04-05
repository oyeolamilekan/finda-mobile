import 'package:finda/widgets/cached_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:wiredash/wiredash.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../controllers/profile/profile.dart';
import '../../extentions/extentions.dart';
import '../../services/copy.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';
import '../auth/change_user_name.dart';
import '../pages.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (ProfileController controller) {
        return SafeArea(
          bottom: false,
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
                controller.getUserComplete();
              },
            ),
            errorWidget: ErrorWidgetContainer(
              title:
                  "Something is wrong somewhere, don't worry we are fixing it.",
              onReload: () {
                controller.getUserComplete();
              },
            ),
            successWidget: (_) => SingleChildScrollView(
              child: Container(
                height: 100.h,
                width: 100.w,
                padding: EdgeInsets.only(top: 2.h),
                margin: EdgeInsets.only(bottom: 2.h),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (controller.imageUploading != AppState.loading) {
                              await controller.uploadImage();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 30.w,
                            height: 30.w,
                            child: STEMCachedNetworkImage(
                              photoUrl: controller.user.photoUrl!,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).cardColor),
                            child: controller.imageUploading == AppState.loading
                                ? CircleProgessBar(
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    width: 18,
                                    height: 18,
                                  )
                                : Icon(
                                    FeatherIcons.camera,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    size: 5.text,
                                  ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      controller.user.fullName ?? "",
                      style: TextStyle(
                        fontSize: 6.text,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            FlutterClipboard.copy(
                              "@${controller.user.username}",
                            ).then(
                              (_) {
                                FindaStyles.successSnackbar(
                                  null,
                                  "Username has been successfully copied.",
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Text(
                              "@${controller.user.username}",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => Get.bottomSheet(
                            ChangeUserName(
                              updateUserName: controller.updateUsername,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Icon(
                              FeatherIcons.settings,
                              color: Theme.of(context).textTheme.button!.color,
                              size: 5.text,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => Share.share(
                            "Here this my finda tag: @${controller.user.username}.",
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Icon(
                              FeatherIcons.share2,
                              color: Theme.of(context).textTheme.button!.color,
                              size: 5.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: InkWell(
                        onTap: () => Share.share(
                          "Heyy! I’ve been using Finda App to easily shop and search instagram without tracking. You should totally try it out too its free! https://finda.ng/",
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Icon(
                                  FeatherIcons.mail,
                                  color:
                                      Theme.of(context).textTheme.button!.color,
                                  size: 5.text,
                                ),
                              ),
                              Text(
                                "Share Finda with your friends",
                                style: Theme.of(context).textTheme.button,
                              ),
                              const Spacer(),
                              Icon(
                                FeatherIcons.chevronRight,
                                color:
                                    Theme.of(context).textTheme.button!.color,
                                size: 5.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => Get.bottomSheet(
                              UserProfile(
                                updateFullName: controller.updateFullName,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).canvasColor,
                                    width: 0.3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Icon(
                                      FeatherIcons.user,
                                      color: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .color,
                                      size: 5.text,
                                    ),
                                  ),
                                  Text(
                                    "My Profile",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    FeatherIcons.chevronRight,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    size: 5.text,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.bottomSheet(
                              ChangePassword(),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).canvasColor,
                                    width: 0.3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Icon(
                                      FeatherIcons.key,
                                      color: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .color,
                                      size: 5.text,
                                    ),
                                  ),
                                  Text(
                                    "Change password",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    FeatherIcons.chevronRight,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    size: 5.text,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Icon(
                                    controller.isDarkMode
                                        ? FeatherIcons.moon
                                        : FeatherIcons.sun,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    size: 5.text,
                                  ),
                                ),
                                Text(
                                  "Switch DarkMode",
                                  style: Theme.of(context).textTheme.button,
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 20,
                                  child: Switch.adaptive(
                                    value: controller.isDarkMode,
                                    activeColor: Colors.black,
                                    onChanged: (value) =>
                                        controller.toggleThemMode(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: InkWell(
                        onTap: () => Get.toNamed("/signOut"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Icon(
                                  FeatherIcons.logOut,
                                  color:
                                      Theme.of(context).textTheme.button!.color,
                                  size: 5.text,
                                ),
                              ),
                              Text(
                                "Sign out",
                                style: Theme.of(context).textTheme.button,
                              ),
                              const Spacer(),
                              Icon(
                                FeatherIcons.chevronRight,
                                color:
                                    Theme.of(context).textTheme.button!.color,
                                size: 5.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: InkWell(
                        onTap: () => Get.toNamed("/signOut"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Icon(
                                  FeatherIcons.logOut,
                                  color:
                                      Theme.of(context).textTheme.button!.color,
                                  size: 5.text,
                                ),
                              ),
                              Text(
                                "Test with N100",
                                style: Theme.of(context).textTheme.button,
                              ),
                              const Spacer(),
                              Icon(
                                FeatherIcons.chevronRight,
                                color:
                                    Theme.of(context).textTheme.button!.color,
                                size: 5.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Wiredash.of(context)?.show();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "v ${controller.packageInfo.version}",
                          style: TextStyle(
                            fontSize: 3.5.text,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
