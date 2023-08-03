import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, this.height = kToolbarHeight});
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 10,
          left: 20,
          right: 20,
          bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          SizedBox(
            width: 25,
            height: 32,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  child: Image.asset(
                    'src/images/icon.png',
                    width: 25,
                  ))
            ]),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "VoteChain",
            style: TextStyle(
                color: Color(0xFF1BA68D),
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins'),
          ),
          const Spacer(),
          // IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, 'admin');
          //     },
          //     icon: const Icon(
          //       Icons.refresh_rounded,
          //       color: Color(0xFF1BA68D),
          //     )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'admin');
              },
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF1BA68D),
              )),
        ],
      ),
    );
  }
}
