import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../controllers/auth/sign_up.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/logo.dart';
import '../../widgets/text_field.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailAddress = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _password = TextEditingController();
  final _password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) => Container(
          height: 100.h,
          width: 100.w,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                  child: Logo(),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FINDATextFormField(
                        labelText: "Email Address",
                        inputAction: TextInputAction.done,
                        textEditingController: _emailAddress,
                        suffixOnClick: () {},
                        enabled: !(controller.loadingState == AppState.loading),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          } else if (!(value?.validateEmail() ?? false)) {
                            return "Please type a valid email";
                          }
                          return null;
                        },
                      ),
                      FINDATextFormField(
                        labelText: "First Name",
                        inputAction: TextInputAction.done,
                        textEditingController: _firstName,
                        enabled: !(controller.loadingState == AppState.loading),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                      ),
                      FINDATextFormField(
                        labelText: "Last Name",
                        inputAction: TextInputAction.done,
                        textEditingController: _lastName,
                        enabled: !(controller.loadingState == AppState.loading),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                      ),
                      FINDATextFormField(
                        labelText: "Type Password",
                        inputAction: TextInputAction.done,
                        textEditingController: _password,
                        obscureText: controller.isPasswordVisible,
                        enabled: !(controller.loadingState == AppState.loading),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          } else if ((value?.length ?? 0) < 8) {
                            return "Password can not be less than 8";
                          }
                          return null;
                        },
                        suffixIcon: controller.isPasswordVisible
                            ? FeatherIcons.eyeOff
                            : FeatherIcons.eye,
                        suffixOnClick: () {
                          controller.togglePasswordAction();
                        },
                      ),
                      FINDATextFormField(
                        labelText: "Re-enter Password",
                        inputAction: TextInputAction.done,
                        textEditingController: _password2,
                        obscureText: controller.isPasswordVisible2,
                        enabled: !(controller.loadingState == AppState.loading),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          } else if ((value?.length ?? 0) < 8) {
                            return "Password can not be less than 8";
                          }
                          return null;
                        },
                        suffixIcon: controller.isPasswordVisible2
                            ? FeatherIcons.eyeOff
                            : FeatherIcons.eye,
                        suffixOnClick: () {
                          controller.togglePasswordAction2();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FINDAButton(
                  color: controller.loadingState == AppState.loading
                      ? Theme.of(context).cardColor.withOpacity(0.5)
                      : Theme.of(context).cardColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.signUpAction(
                        _emailAddress.text,
                        _firstName.text,
                        _lastName.text,
                        _password.text,
                        _password2.text,
                      );
                      if (controller.loadingState == AppState.success) {
                        _emailAddress.clear();
                        _firstName.clear();
                        _lastName.clear();
                        _password.clear();
                        _password2.clear();
                        FindaStyles.successSnackbar(
                          null,
                          controller.message!,
                        );
                      } else {
                        FindaStyles.errorSnackBar(
                          null,
                          "controller.error.detail",
                        );
                      }
                    }
                  },
                  child: controller.loadingState == AppState.loading
                      ? const CircleProgessBar(color: Colors.white)
                      : Text(
                          "Sign up",
                          style: Theme.of(context).textTheme.button,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Alread have an account? sign in."),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
