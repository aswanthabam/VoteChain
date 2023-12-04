import 'package:flutter/material.dart';

class BackBar extends StatelessWidget implements PreferredSizeWidget {
  const BackBar(
      {super.key,
      required this.onPressed,
      this.icon,
      this.height = kToolbarHeight});
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  final Function() onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Row(
        children: [
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon ?? Icons.arrow_back_ios,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
