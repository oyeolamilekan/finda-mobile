import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../const/loading_const.dart';
import '../../controllers/profile/user_profile.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';
import '../../widgets/text_field.dart';

class UserProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function? updateFullName;

  UserProfile({
    Key? key,
    this.updateFullName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
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
                controller.userDetail();
              },
            ),
            errorWidget: ErrorWidgetContainer(
              title:
                  "Something is wrong somewhere, don't worry we are fixing it.",
              onReload: () {
                controller.userDetail();
              },
            ),
            successWidget: (_) => SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FINDATextFormField(
                      labelText: "First Name",
                      textEditingController: controller.firstName,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Field can't be empty";
                        }
                        return null;
                      },
                    ),
                    FINDATextFormField(
                      labelText: "Last Name",
                      textEditingController: controller.lastName,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Field can't be empty";
                        }
                        return null;
                      },
                    ),
                    FINDATextFormField(
                      labelText: "Email",
                      textEditingController: controller.email,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Field can't be empty";
                        } else if (!(value?.validateEmail() ?? false)) {
                          return "Please type a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    FINDAButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            controller.btnLoading != AppState.loading) {
                          await controller.updateUser(
                            controller.firstName.text,
                            controller.lastName.text,
                            controller.email.text,
                          );
                          if (controller.btnLoading == AppState.none) {
                            updateFullName!(
                              "${controller.firstName.text.capitalize()} ${controller.lastName.text.capitalize()}",
                            );
                          }
                        }
                      },
                      color: controller.btnLoading != AppState.loading
                          ? Theme.of(context).cardColor
                          : Theme.of(context).cardColor.withOpacity(0.5),
                      child: Text(
                        controller.btnLoading == AppState.loading
                            ? "Submitting"
                            : "Submit",
                        style: Theme.of(context).textTheme.button,
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
