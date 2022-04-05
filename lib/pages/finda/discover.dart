import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../extentions/extentions.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.1),
            child: SizedBox(
              height: 70.w,
              child: Lottie.asset(
                "assets/lottie/planets.json",
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.15),
            child: Text(
              "Coming soon.",
              style: TextStyle(
                fontSize: 5.5.text,
              ),
            ),
          )
        ],
      ),
    );
  }
}
