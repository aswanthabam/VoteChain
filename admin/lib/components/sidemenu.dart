import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  SideMenu({super.key, required this.selected});
  String selected;
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
            selected: widget.selected == "home",
            onClicked: () {
              Navigator.pushReplacementNamed(context, "home");
            },
            icon: Icons.home_rounded,
            text: "Home",
          ),
          SideMenuButton(
            selected: widget.selected == "elections",
            onClicked: () {},
            icon: Icons.poll_rounded,
            text: "Elections",
          ),
          SideMenuButton(
            selected: widget.selected == "candidates",
            onClicked: () {},
            icon: Icons.person,
            text: "Candidates",
          ),
          SideMenuButton(
            selected: widget.selected == "voters",
            onClicked: () {},
            icon: Icons.people_alt_rounded,
            text: "Voters",
          ),
          SideMenuButton(
            selected: widget.selected == "admin",
            onClicked: () {
              Navigator.pushReplacementNamed(context, "admin");
            },
            icon: Icons.settings,
            text: "Settings",
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
      required this.text,
      this.selected = false});
  Function()? onClicked;
  IconData? icon;
  String? text;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClicked,
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          backgroundColor: selected ? Colors.white : Colors.transparent),
      child: Row(
        children: [
          Icon(
            icon,
            color: selected ? Colors.purple[800] : Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style:
                TextStyle(color: selected ? Colors.purple[800] : Colors.white),
          )
        ],
      ),
    );
  }
}
