import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../extentions/extentions.dart';

class FINDAButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;
  final double radius;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const FINDAButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height = 55.0,
    this.radius = 5,
    this.color,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: width ?? 100.w,
      height: height,
      margin: margin,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class FINDAOutlineButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;
  final double radius;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final List<BoxShadow>? boxShadow;

  const FINDAOutlineButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height = 55.0,
    this.radius = 5,
    this.color,
    this.padding,
    this.margin,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: width ?? 100.w,
      height: height,
      margin: margin,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Theme.of(context).cardColor),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class FINDADropDowmButton extends StatefulWidget {
  final String? title;
  final List? items;
  final Widget? child;
  final double? width;

  const FINDADropDowmButton({
    Key? key,
    this.title,
    this.items,
    this.child,
    this.width,
  }) : super(key: key);
  @override
  _FINDADropDowmButtonState createState() => _FINDADropDowmButtonState();
}

class _FINDADropDowmButtonState extends State<FINDADropDowmButton> {
  bool showBottom = false;

  double? height, width, xPosition, yPosition, size;

  late OverlayEntry floatingDropdown;
  int? lengthOfValue;
  GlobalKey? actionKey;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    lengthOfValue = widget.items!.length;
    actionKey = LabeledGlobalKey(widget.title);
    super.initState();
  }

  void findDropdownData() {
    final RenderBox? renderBox =
        actionKey?.currentContext?.findRenderObject() as RenderBox?;
    height = renderBox?.size.height;
    width = renderBox?.size.width;
    final Offset offset = renderBox!.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropDown() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: width,
          height: 12.h,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, height! + 5.0),
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.17),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: widget.items!.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final Widget selectDropDown =
                        widget.items![index] as Widget;
                    return selectDropDown;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: actionKey,
      onTap: () {
        if (!showBottom) {
          findDropdownData();
          floatingDropdown = _createFloatingDropDown();
          Overlay.of(context)!.insert(floatingDropdown);
        } else {
          floatingDropdown.remove();
        }
        showBottom = !showBottom;
        setState(() {});
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}
