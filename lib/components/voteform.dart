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
            padding: const EdgeInsets.all(20),
            child: const Column(
              children: [],
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
                padding: const EdgeInsets.all(10),
                iconColor: Colors.white),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
