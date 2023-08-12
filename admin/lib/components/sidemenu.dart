import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool expanded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.purple.shade800),
      height: MediaQuery.of(context).size.height,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white30),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.volunteer_activism,
                  color: Colors.green.shade400,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "VoteChain : Admin",
                  style: TextStyle(color: Colors.green.shade400),
                )
              ],
            ),
          ),
          SideMenuButton(
            onClicked: () {},
            icon: Icons.home_rounded,
            text: "Home",
          ),
          SideMenuButton(
            onClicked: () {},
            icon: Icons.poll_rounded,
            text: "Elections",
          ),
          SideMenuButton(
            onClicked: () {},
            icon: Icons.person,
            text: "Candidates",
          ),
          SideMenuButton(
            onClicked: () {},
            icon: Icons.people_alt_rounded,
            text: "Voters",
          ),
          const Spacer(),
          Center(
            child: Text(
              "v 1.0.0",
              style: TextStyle(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  SideMenuButton(
      {super.key,
      required this.onClicked,
      required this.icon,
      required this.text});
  Function()? onClicked;
  IconData? icon;
  String? text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClicked,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text!,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
