import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../const/loading_const.dart';
import '../../controllers/auth/change_password.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class ChangePassword extends StatelessWidget {
  final _oldPassword = TextEditingController();
  final _newPassWord = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) => Container(
        height: 43.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FINDATextFormField(
                  labelText: "Old Password",
                  textEditingController: _oldPassword,
                  obscureText: true,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? false) {
                      return "Field can't be empty";
                    } else if ((value?.length ?? 0) < 6) {
                      return "Password more longer that 9 characters";
                    }
                    return null;
                  },
                ),
                FINDATextFormField(
                  labelText: "New Password",
                  textEditingController: _newPassWord,
                  obscureText: true,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? false) {
                      return "Field can't be empty";
                    } else if ((value?.length ?? 0) < 6) {
                      return "Password more longer that 9 characters";
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
                        controller.loading != AppState.loading) {
                      await controller.changePasswordAction(
                        _oldPassword.text,
                        _newPassWord.text,
                      );
                    }
                  },
                  color: controller.loading != AppState.loading
                      ? Theme.of(context).cardColor
                      : Theme.of(context).cardColor.withOpacity(0.5),
                  child: Text(
                    controller.loading != AppState.loading
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
