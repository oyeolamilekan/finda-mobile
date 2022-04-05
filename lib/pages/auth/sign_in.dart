import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../config/size_config.dart';
import '../../const/loading_const.dart';
import '../../controllers/auth/sign_in.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/text_field.dart';

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailAddress = TextEditingController();
  final _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) => Container(
          height: 100.h,
          width: 100.w,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      "Hey you're back, fill in your details to get back in.",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  FINDATextFormField(
                    labelText: "Email Address",
                    enabled: !(controller.loadingState == AppState.loading),
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
                  FINDATextFormField(
                    labelText: "Password",
                    textEditingController: _passWord,
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
                  if (controller.isLoggedIn)
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                      ),
                      child: InkWell(
                        onTap: () async {
                          final LocalAuthentication localAuth =
                              LocalAuthentication();
                          final bool didAuthenticate =
                              await localAuth.authenticate(
                            localizedReason: 'Please authenticate to log in.',
                          );
                          if (didAuthenticate) {
                            await controller.signInWithoutPassword();
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/svg/fingerprint.svg",
                          width: 10.w,
                          color: Theme.of(context).textTheme.button?.color,
                        ),
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
                      if (_formKey.currentState!.validate() &&
                          controller.loadingState != AppState.loading) {
                        await controller.signInAction(
                          _emailAddress.text,
                          _passWord.text,
                        );
                      }
                    },
                    child: controller.loadingState == AppState.loading
                        ? const CircleProgessBar(color: Colors.white)
                        : Text(
                            "Sign in",
                            style: Theme.of(context).textTheme.button,
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed("/resetPassword"),
                    child: const Text("Forgot Password?"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed("/signUp"),
                    child: const Text("Don't have an account? sign up."),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
