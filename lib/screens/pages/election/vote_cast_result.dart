import 'package:flutter/material.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:web3dart/web3dart.dart';

class VoteCastResultDialog extends StatefulWidget {
  const VoteCastResultDialog(
      {super.key, required this.candidateAddress, required this.electionId});
  final EthereumAddress candidateAddress;
  final int electionId;
  @override
  State<VoteCastResultDialog> createState() => _VoteCastResultDialogState();
}

class _VoteCastResultDialogState extends State<VoteCastResultDialog> {
  late Future<bool> waiter;
  bool voteCasted = false;
  @override
  void initState() {
    super.initState();
    waiter = VoterHelper().vote(widget.candidateAddress, widget.electionId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: waiter,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    voteCasted
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      voteCasted ? "Successfuly Voted" : "Failed to cast vote",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close"),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  ]),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Casting Vote ...",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please wait while we cast your vote",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ]),
                );
              }
            }));
  }
}
