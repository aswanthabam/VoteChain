import 'package:flutter/material.dart';

class MsgDialog extends StatelessWidget {
  MsgDialog(
      {super.key,
      required this.text,
      this.icon,
      this.iconColor,
      this.iconSize});
  String text;
  IconData? icon;
  Color? iconColor;
  double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: iconSize,
              width: double.infinity,
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [Text(text)],
            )
          ],
        ),
      ),
    );
  }
}
