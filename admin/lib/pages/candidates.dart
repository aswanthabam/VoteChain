import 'package:admin/components/dialog.dart';
import 'package:flutter/material.dart';
import '../classes/global.dart';
import '../Election.g.dart';

class CandidatesWidget extends StatefulWidget {
  const CandidatesWidget({super.key});

  @override
  State<CandidatesWidget> createState() => _CandidatesWidgetState();
}

class _CandidatesWidgetState extends State<CandidatesWidget> {
  List<Elections> elections = [];
  @override
  void initState() {
    super.initState();
    Global.linker.getElections(onError: () {
      showDialog(
          context: context,
          builder: (context) =>
              MsgDialog(text: "Unable to get election details"));
    }).then((value) {
      setState(() {
        elections = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: elections
              .map((e) => Row(
                    children: [Text(e.name)],
                  ))
              .toList(),
        ));
  }
}
