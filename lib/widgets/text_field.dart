import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../extentions/extentions.dart';

class FINDATextFormField extends StatefulWidget {
  /*
   * This is an abstractions of flutter textfiled but with 
   * an added advantage with the default style from design
   * 
   * 
   */
  final TextEditingController? textEditingController;
  final String? title;
  final String? labelText;
  final Function(String)? onChange;
  final VoidCallback? callBackOnFocus;
  final VoidCallback? callBackOffFocus;
  final VoidCallback? onEditingComplete;
  final TextInputType? textInputType;
  final IconData? suffixIcon;
  final IconData? preffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? prefixOnClick;
  final VoidCallback? suffixOnClick;
  final bool obscureText;
  final int? maxLength;
  final bool isBoarder;
  final TextInputAction? inputAction;
  final bool? enabled;
  final int maxLines;
  const FINDATextFormField({
    Key? key,
    this.textEditingController,
    this.title,
    this.labelText,
    this.textInputType,
    this.onChange,
    this.validator,
    this.obscureText = false,
    this.callBackOnFocus,
    this.callBackOffFocus,
    this.maxLength,
    this.preffixIcon,
    this.suffixIcon,
    this.prefixOnClick,
    this.suffixOnClick,
    this.onEditingComplete,
    this.isBoarder = true,
    this.inputAction,
    this.enabled,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _FINDATextFormFieldState createState() => _FINDATextFormFieldState();
}

class _FINDATextFormFieldState extends State<FINDATextFormField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(
      () {
        if (widget.callBackOnFocus != null) {
          if (_focusNode.hasFocus) {
            widget.callBackOnFocus!();
          } else {
            widget.callBackOffFocus!();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.5.h,
        ),
        if (widget.title != null) Text(widget.title!),
        SizedBox(
          height: 1.h,
        ),
        TextFormField(
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          textInputAction: widget.inputAction,
          enabled: widget.enabled ?? true,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
            fillColor: Colors.white,
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: widget.suffixOnClick,
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      child: Icon(
                        widget.suffixIcon,
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(0.4),
                      ),
                    ),
                  )
                : null,
            prefixIcon: widget.preffixIcon != null
                ? InkWell(
                    onTap: widget.prefixOnClick,
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      child: Icon(
                        widget.preffixIcon,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  )
                : null,
            prefixStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            border: widget.isBoarder
                ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
            focusedBorder: widget.isBoarder
                ? const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
            enabledBorder: widget.isBoarder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
          ),
          validator: widget.validator,
          onChanged: widget.onChange,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          maxLength: widget.maxLength,
          onEditingComplete: widget.onEditingComplete,
        ),
      ],
    );
  }
}
