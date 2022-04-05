import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../const/loading_const.dart';
import '../../const/styles.dart';
import '../../controllers/auth/password_reset.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/text_field.dart';

class ResetPassword extends StatelessWidget {
  final _emailAddress = TextEditingController();
  final _token = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _secondFormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: GetBuilder(
          init: PasswordResetController(),
          builder: (PasswordResetController value) => PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.mail,
                      size: 15.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 70.w,
                      alignment: Alignment.center,
                      child: const Text(
                        "Enter your email and we will send you, instructions on how to reset your password.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: FINDATextFormField(
                        labelText: "Enter email",
                        preffixIcon: FeatherIcons.mail,
                        textEditingController: _emailAddress,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Field can't be empty";
                          } else if (!(value?.validateEmail() ?? false)) {
                            return "Please type a valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FINDAButton(
                      color: value.loading == AppState.loading
                          ? Theme.of(context).cardColor.withOpacity(0.5)
                          : Theme.of(context).cardColor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await value.requestEmail(_emailAddress.text);
                          if (value.loading == AppState.success) {
                            controller.nextPage(
                              duration: const Duration(microseconds: 970),
                              curve: Curves.easeIn,
                            );
                          }
                        }
                      },
                      child: value.loading == AppState.loading
                          ? const CircleProgessBar(color: Colors.white)
                          : Text(
                              "Send Reset Email",
                              style: Theme.of(context).textTheme.button,
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _secondFormKey,
                      child: Column(
                        children: [
                          FINDATextFormField(
                            labelText: "Enter Code",
                            preffixIcon: FeatherIcons.code,
                            textEditingController: _token,
                            textInputType: TextInputType.number,
                            enabled: !(value.loading == AppState.loading),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? false) {
                                return "Field can't be empty";
                              }
                              return null;
                            },
                          ),
                          FINDATextFormField(
                            labelText: "Enter New Password",
                            preffixIcon: FeatherIcons.key,
                            textEditingController: _password,
                            obscureText: value.isPasswordVisible,
                            enabled: !(value.loading == AppState.loading),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? false) {
                                return "Field can't be empty";
                              }
                              return null;
                            },
                            suffixIcon: value.isPasswordVisible
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye,
                            suffixOnClick: () {
                              value.togglePasswordAction();
                            },
                          ),
                          FINDATextFormField(
                            labelText: "Confirm New Password",
                            preffixIcon: FeatherIcons.key,
                            textEditingController: _confirmPassword,
                            obscureText: value.isConfirmPassword,
                            enabled: !(value.loading == AppState.loading),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? false) {
                                return "Field can't be empty";
                              }
                              return null;
                            },
                            suffixIcon: value.isConfirmPassword
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye,
                            suffixOnClick: () {
                              value.toggleConfirmPasswordAction();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FINDAButton(
                      color: value.loading == AppState.loading
                          ? Theme.of(context).cardColor.withOpacity(0.5)
                          : Theme.of(context).cardColor,
                      onPressed: () async {
                        if (_secondFormKey.currentState!.validate()) {
                          if (_password.text.trim() !=
                              _confirmPassword.text.trim()) {
                            Get.snackbar(
                              '',
                              "Password does not match.",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                              borderRadius: 5,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              backgroundColor: hexToColor("#f60200"),
                              duration: const Duration(seconds: 5),
                            );
                          } else {
                            await value.resetPassword(
                              _token.text.trim(),
                              _password.text.trim(),
                              _confirmPassword.text.trim(),
                            );
                            if (value.loading == AppState.success) {
                              _secondFormKey.currentState?.reset();
                              _token.clear();
                              _password.clear();
                              _confirmPassword.clear();
                              Get.snackbar(
                                '',
                                value.passwordResetModel.detail!,
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                borderRadius: 5,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                backgroundColor: hexToColor("#0066f5"),
                                duration: const Duration(seconds: 3),
                              );
                              await Future.delayed(const Duration(seconds: 3));
                              Get.offAndToNamed("/signIn");
                            } else {
                              Get.snackbar(
                                '',
                                "value.error.detail",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                borderRadius: 5,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                backgroundColor: hexToColor("#f60200"),
                                duration: const Duration(seconds: 5),
                              );
                            }
                          }
                        }
                      },
                      child: value.loading == AppState.loading
                          ? const CircleProgessBar(color: Colors.white)
                          : Text(
                              "Reset Password",
                              style: Theme.of(context).textTheme.button,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
