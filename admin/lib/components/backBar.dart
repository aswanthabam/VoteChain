import 'package:flutter/material.dart';

class BackBar extends StatelessWidget {
  BackBar({super.key, required this.onPressed, this.icon});
  Function() onPressed;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon ?? Icons.arrow_back_ios,
            )),
        const Spacer(),
      ],
    );
  }
}
