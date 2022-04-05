import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ErrorWidgetContainer extends StatelessWidget {
  final VoidCallback? onReload;
  final String title;

  const ErrorWidgetContainer({
    Key? key,
    this.onReload,
    this.title = "Shot, something is wrong with your internet",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FeatherIcons.cloudOff,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: onReload,
              child: const Text("Reload page"),
            )
          ],
        ),
      ),
    );
  }
}
