import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../const/loading_const.dart';
import '../../controllers/auth/change_username.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/error_widget_container.dart';
import '../../widgets/suspense.dart';
import '../../widgets/text_field.dart';

class ChangeUserName extends StatelessWidget {
  final Function? updateUserName;
  final _formKey = GlobalKey<FormState>();

  ChangeUserName({Key? key, this.updateUserName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeUsernameController>(
      init: ChangeUsernameController(),
      builder: (controller) => Container(
        height: 25.h,
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
              controller.getUsername();
            },
          ),
          errorWidget: ErrorWidgetContainer(
            title:
                "Something is wrong somewhere, don't worry we are fixing it.",
            onReload: () {
              controller.getUsername();
            },
          ),
          successWidget: (_) => Form(
            key: _formKey,
            child: Column(
              children: [
                FINDATextFormField(
                  labelText: "Username",
                  textEditingController: controller.userName,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? false) {
                      return "Field can't be empty";
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
                      await controller.updateUsername();
                      if (controller.btnLoading == AppState.none) {
                        updateUserName!(controller.userName.text);
                      }
                    }
                  },
                  color: controller.btnLoading != AppState.loading
                      ? Theme.of(context).cardColor
                      : Theme.of(context).cardColor.withOpacity(0.5),
                  child: Text(
                    controller.btnLoading != AppState.loading
                        ? "Submit"
                        : "Saving..",
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
