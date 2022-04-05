import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../const/loading_const.dart';
import '../../controllers/wishlist/create_wishlist_controller.dart';
import '../../extentions/extentions.dart';
import '../../widgets/button.dart';
import '../../widgets/circle_progess_bar.dart';
import '../../widgets/text_field.dart';

class CreateWishList extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CreateWishListController>(
          init: CreateWishListController(),
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FINDAButton(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).cardColor,
                    radius: 100,
                    onPressed: () => Get.back(),
                    child: Icon(
                      FeatherIcons.chevronLeft,
                      color: Theme.of(context).textTheme.button!.color,
                      size: 4.5.text,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create Wishlist",
                    style: TextStyle(
                      fontSize: 6.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  FINDATextFormField(
                    title: "Title",
                    textEditingController: _titleController,
                    labelText: "Give your wishlist a unique name.",
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? false) {
                        return "Field can't be empty";
                      } else if ((value?.length ?? 0) < 8) {
                        return "Title can not be less than 8";
                      }
                      return null;
                    },
                  ),
                  FINDATextFormField(
                    title: "Description",
                    textEditingController: _descriptionController,
                    labelText: "Give your wishlist a unique description.",
                    maxLines: 4,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? false) {
                        return "Field can't be empty";
                      } else if ((value?.length ?? 0) < 8) {
                        return "Description can not be less than 8";
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Is private"),
                        SizedBox(
                          height: 20,
                          child: Switch.adaptive(
                            value: controller.isPrivate,
                            activeColor: Colors.black,
                            onChanged: (value) => controller.togglePrivate(),
                          ),
                        )
                      ],
                    ),
                  ),
                  FINDAButton(
                    color: controller.loadingState == AppState.loading
                        ? Theme.of(context).cardColor.withOpacity(0.5)
                        : Theme.of(context).cardColor,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.createWishlistAction(
                          _titleController.text,
                          _descriptionController.text,
                        );
                      }
                    },
                    child: controller.loadingState == AppState.loading
                        ? const CircleProgessBar(color: Colors.white)
                        : Text(
                            "Create Wishlist",
                            style: Theme.of(context).textTheme.button,
                          ),
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
