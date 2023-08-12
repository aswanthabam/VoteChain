import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Spacer()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Quick Actions",
                style: TextStyle(color: Colors.grey.shade500),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              QuickButton(
                  onPressed: () {},
                  text: "Voter Approval",
                  icon: Icons.approval_rounded)
            ],
          )
        ],
      ),
    );
  }
}

class QuickButton extends StatefulWidget {
  QuickButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});
  Function onPressed;
  String text;
  IconData icon;
  @override
  State<QuickButton> createState() => _QuickButtonState();
}

class _QuickButtonState extends State<QuickButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1)),
        width: 100,
        height: 100,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(widget.icon),
          Text(
            widget.text,
            textAlign: TextAlign.center,
          )
        ]));
  }
}
