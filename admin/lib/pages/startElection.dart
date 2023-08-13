import 'package:flutter/material.dart';
import '../components/backBar.dart';
import '../classes/global.dart';
import '../components/dialog.dart';

class StartElection extends StatelessWidget {
  StartElection({super.key});
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          BackBar(onPressed: () {
            Navigator.pop(context);
          }),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Name of the election"),
            controller: nameController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Global.linker.addElection("MyElection1", onError: () {
                  showDialog(
                      context: context,
                      builder: (context) => MsgDialog(
                            text: "Error Adding election",
                            icon: Icons.error,
                            iconColor: Colors.red,
                          ));
                }).then((value) {
                  if (value) {
                    showDialog(
                        context: context,
                        builder: (context) => MsgDialog(
                              text: "Successfully added election",
                              icon: Icons.done,
                            ));
                  }
                });
              },
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
