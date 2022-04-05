import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:wiredash/wiredash.dart';

import '../../widgets/features.dart';

class ChangeLogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "WHAT'S NEW: 2.0.1",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Wiredash.of(context)?.show(),
              child: const Icon(FeatherIcons.messageSquare),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return FINDAFeatureContainer();
        },
      ),
    );
  }
}
