import 'package:flutter/material.dart';
import '../classes/contract_linker.dart';

class VoteForm extends StatefulWidget {
  VoteForm({super.key, required this.linker});
  ContractLinker linker;
  @override
  State<VoteForm> createState() => _VoteFormState();
}

class _VoteFormState extends State<VoteForm> {
  void showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                    child: Text(
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        "Candidates")),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: widget.linker.loadCandidates(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (snapshot.hasError || !snapshot.hasData)
                        return Center(
                          child: Text("Error Loading"),
                        );
                      else
                        return SizedBox(
                            height: 200,
                            child: ListView(
                              children: snapshot.data!
                                  .map((e) => Container(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        top: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade400),
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade400),
                                      )),
                                      child: Row(children: [
                                        Expanded(child: Text(e.name)),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await widget.linker
                                                .requestEthers(context);
                                            await widget.linker
                                                .voteCandidate(e.id, context);
                                            widget.linker.loadCandidates2();
                                          },
                                          child: Text("Vote"),
                                        )
                                      ])))
                                  .toList(),
                            ));
                    }))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              showPicker();
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade300,
                padding: EdgeInsets.all(10),
                iconColor: Colors.white),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  "Cast Your Vote"),
              SizedBox(width: 10),
              Icon(Icons.send_outlined)
            ]),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
