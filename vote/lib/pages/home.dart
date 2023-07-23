import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/components/results.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import '../Election.g.dart';
import 'package:vote/classes/contract_linker.dart';
import 'package:vote/components/voteform.dart';
import '../classes/preferences.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ContractLinker linker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    // await Preferences.init();
    linker = ContractLinker();
    linker.init(cond: Preferences.init());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          VoteForm(
            linker: linker,
          ),
          SizedBox(
            height: 10,
          ),
          Results(linker: linker),
          ChangeNotifierProvider<ContractLinker>(
            create: (context) => linker,
            child: Consumer<ContractLinker>(
              builder: (context, linker, _) => Info(linker: linker),
            ),
          )
        ]),
      ),
    );
  }
}

class Info extends StatelessWidget {
  Info({super.key, required this.linker});

  ContractLinker linker;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: () {
                      linker.createAccount();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.blue.shade300,
                      iconColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            style: TextStyle(color: Colors.white),
                            "Create Account"),
                        Icon(Icons.add)
                      ],
                    ))),
          ],
        ),
        Row(children: [
          Expanded(
              child: TextButton(
                  onPressed: () {
                    linker.requestEthers(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: Colors.blue.shade600,
                    iconColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          style: TextStyle(color: Colors.white),
                          "Fund Account"),
                      Icon(Icons.add)
                    ],
                  ))),
        ]),
        Center(
            child: Row(children: [
          Text(
            "Your Address: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: linker.getAddress(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return SelectableText(snapshot.data.toString(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                  else
                    return SelectableText("Loading",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                }),
          )
        ])),
        Center(
            child: Row(children: [
          Text(
            "Your Private Key: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: linker.getCredentials(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return SelectableText(
                        bytesToHex(snapshot.data!.privateKey).toString(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                  else
                    return SelectableText("Loading",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                }),
          )
        ])),
        Center(
            child: Row(children: [
          Text(
            "Balance: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: linker.getBalance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return SelectableText(snapshot.data.toString(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                  else
                    return SelectableText("Loading",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis,
                        ));
                }),
          )
        ]))
      ],
    );
  }
}
