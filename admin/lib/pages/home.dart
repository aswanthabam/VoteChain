import 'package:admin/main.dart';
import 'package:flutter/material.dart';
import '../classes/contract_linker.dart';
import '../components/dialog.dart';
import '../classes/global.dart';
import '../Election.g.dart';
import 'startElection.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int electionCount = 0;
  List<Elections> elections = [];
  @override
  void initState() {
    super.initState();
    Global.linker.getElections(onError: () {
      showDialog(
          context: context,
          builder: (context) =>
              MsgDialog(text: "An error occure while fetching elections"));
    }).then((value) {
      setState(() {
        elections = value;
        electionCount = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  QuickButton(
                      onPressed: () {},
                      text: "Voter Approval",
                      icon: Icons.approval_rounded),
                  const SizedBox(
                    width: 20,
                  ),
                  QuickButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainApp(
                                    child: StartElection(), selected: "home")));
                      },
                      text: "Start Election",
                      icon: Icons.add),
                  const SizedBox(
                    width: 20,
                  ),
                  QuickButton(
                      onPressed: () {},
                      text: "Statistics",
                      icon: Icons.auto_graph_rounded),
                  const SizedBox(
                    width: 20,
                  ),
                  QuickButton(
                      onPressed: () {},
                      text: "Queries",
                      icon: Icons.help_outline),
                ],
              )),
          const SizedBox(height: 20),
          Text("Election count : ${electionCount}")
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
  void Function() onPressed;
  String text;
  IconData icon;
  @override
  State<QuickButton> createState() => _QuickButtonState();
}

class _QuickButtonState extends State<QuickButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1)),
            width: 100,
            height: 100,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
              )
            ])));
  }
}
