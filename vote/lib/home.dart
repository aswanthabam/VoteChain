import 'package:flutter/material.dart';
import 'package:vote/results.dart';
import 'Election.g.dart';
import 'package:vote/contract_linker.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.linker});

  ContractLinker linker;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Results(linker: widget.linker)
      ]),
    );
  }
}
