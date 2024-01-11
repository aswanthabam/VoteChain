import 'package:flutter/material.dart';

class BackBar extends StatelessWidget implements PreferredSizeWidget {
  final Color background;
  const BackBar(
      {super.key,
      required this.onPressed,
      this.icon,
      this.height = kToolbarHeight,
      this.background = Colors.white});
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  final Function() onPressed;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: background),
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Row(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: icon ?? const Icon(Icons.arrow_back_ios),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
