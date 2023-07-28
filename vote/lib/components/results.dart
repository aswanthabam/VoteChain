import 'package:flutter/material.dart';
import '../Election.g.dart';
import 'package:vote/classes/contract_linker.dart';
import 'package:provider/provider.dart';

class Results extends StatefulWidget {
  Results({super.key, required this.linker});
  ContractLinker linker;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    super.initState();
    // widget.linker.loadCandidates2();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinker>(
      create: (context) => widget.linker,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: Text("Results",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ))),
              IconButton(
                  onPressed: () {
                    setState(() {
                      // widget.linker.loadCandidates2();
                    });
                  },
                  icon: Icon(Icons.refresh))
            ]),
            SizedBox(
              height: 10,
            ),
            Consumer<ContractLinker>(
              builder: (context, linker, _) => FutureBuilder(
                future: linker.candidates,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Text("Loading"),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey.shade600.withAlpha(200),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error Loading");
                  } else {
                    return SizedBox(
                        // height: 300,
                        child: Table(
                            border: TableBorder.all(),
                            defaultColumnWidth: FlexColumnWidth(),
                            children: () {
                              var m = [
                                TableRow(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withAlpha(100)),
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: Text(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            "Name")),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withAlpha(100)),
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: Text(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            "Votes"))
                                  ],
                                ),
                              ];
                              m.addAll(snapshot.data!.map((e) => TableRow(
                                    children: [
                                      Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          child: Text(e.name)),
                                      Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          child: Text(
                                              e.voteCount.toInt().toString()))
                                    ],
                                  )));
                              return m;
                            }()));
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
