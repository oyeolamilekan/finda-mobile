import 'package:flutter/material.dart';

import 'cached_image_provider.dart';

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String imageUrl;
  final double height;

  SectionHeaderDelegate(this.imageUrl, [this.height = 100]);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              child: STEMCachedNetworkImage(
                photoUrl: imageUrl,
              ),
            ),
            const Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.")
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height * 1.8;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
