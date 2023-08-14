import 'package:admin/components/dialog.dart';
import 'package:flutter/material.dart';
import '../classes/global.dart';
import '../Election.g.dart';
import 'dart:ui';

class ElectionsWidget extends StatefulWidget {
  const ElectionsWidget({super.key});

  @override
  State<ElectionsWidget> createState() => _ElectionsWidgetState();
}

class _ElectionsWidgetState extends State<ElectionsWidget> {
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
    return Column(
      children: [
        const SizedBox(height: 20),
        Text("Elections",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Container(
          height: 500,
          padding: EdgeInsets.all(20),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch
            }),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: elections
                  .map((e) => Column(children: [
                        ElectionCard(election: e),
                        const SizedBox(height: 20)
                      ]))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class ElectionCard extends StatelessWidget {
  ElectionCard({super.key, required this.election});
  Elections election;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(40),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 130,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            election.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Election Id ",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Text(": ${election.id}"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Status ", style: TextStyle(fontWeight: FontWeight.w700)),
              Text(election.ended
                  ? "Election Ended"
                  : election.started
                      ? "Election On Going "
                      : "Election not started"),
              Text(election.acceptrequest
                  ? ", Accepting Candidate Applications"
                  : "")
            ],
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (!election.started) {
                      // Implement
                    }
                  },
                  child: Text(election.started
                      ? "Election Started"
                      : "Start Election")),
              TextButton(
                  onPressed: () {
                    if (!election.started) {
                      // Implement
                    }
                  },
                  child:
                      Text(election.ended ? "Election Ended" : "End Election")),
              TextButton(
                  onPressed: () {
                    if (!election.ended) {
                      // Implement
                    }
                  },
                  child: Text("Delete Election",
                      style: TextStyle(color: Colors.red)))
            ],
          )
        ]),
      ),
    );
  }
}
