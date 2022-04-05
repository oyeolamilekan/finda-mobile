import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FINDAPhotoView extends StatelessWidget {
  final ImageProvider image;

  const FINDAPhotoView({
    Key? key,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: image,
    );
  }
}
