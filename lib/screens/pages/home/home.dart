import 'package:flutter/material.dart';
import 'package:vote/contracts/VoteChain.g.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String address = "";
  String balance = "";
  bool isVerified = false;
  VoterStatus status = VoterStatus.registered;
  List<apiTypes.Election> upcomingElections = [];
  List<apiTypes.Election> ongoingElections = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    status =
        await VoterHelper().fetchRegistrationStatus() ?? VoterStatus.registered;
    setState(() {
      status = status;
    });
    await VoterHelper().fetchInfo();
    Global.logger.i(
        "About the voter : \n - ${VoterHelper.voterRegistrationStatus!.message} \n ${VoterHelper.voterInfo!.toJson()}");
    Contracts.votechain
        ?.getUpComingElections$2(VoterHelper.voterInfo?.constituency ?? "")
        .then((value) {
      Global.logger.d("Upcoming elections: $value");
      upcomingElections = value
          .map<apiTypes.Election>((e) => apiTypes.Election.fromList(e))
          .toList();
      setState(() {});
    });
    Contracts.votechain
        ?.getOnGoingElections(VoterHelper.voterInfo?.constituency ?? "")
        .then((value) {
      Global.logger.d("Ongoing elections: $value");
      ongoingElections = value
          .map<apiTypes.Election>((e) => apiTypes.Election.fromList(e))
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (status == VoterStatus.registered
                          ? const AccountStatusCard(
                              statusText: "Not Verified",
                              statusDescription: "Waiting for verification",
                              status: false,
                            )
                          : const AccountStatusCard(
                              statusText: "Account Verified",
                              statusDescription: "You can now access votechain",
                              status: true,
                            )),
                      const SizedBox(height: 15),
                      const UnderlinedText(
                          heading: "Ongoing Elections",
                          fontSize: 17,
                          color: Colors.black,
                          underlineColor: Colors.black,
                          underlineWidth: 100,
                          underlineHeight: 4),
                      const SizedBox(
                        height: 0,
                      ),
                      Column(
                        children: ongoingElections
                            .map<Widget>((e) => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.name} (ID: ${e.id})",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              e.description,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        )))))
                            .toList(),
                      ),
                      const SizedBox(height: 15),
                      const UnderlinedText(
                          heading: "Upcoming Elections",
                          fontSize: 17,
                          color: Colors.black,
                          underlineColor: Colors.black,
                          underlineWidth: 100,
                          underlineHeight: 4),
                      const SizedBox(
                        height: 0,
                      ),
                      Column(
                        children: upcomingElections
                            .map<Widget>((e) => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.name} (ID: ${e.id})",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              e.description,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        )))))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class AccountStatusCard extends StatelessWidget {
  final String statusText;
  final String statusDescription;
  final bool status;
  const AccountStatusCard(
      {super.key,
      required this.statusText,
      required this.statusDescription,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            color: status ? Colors.green.shade200 : Colors.orange.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const SizedBox(width: 20),
            const Icon(Icons.info_outline, size: 40),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(statusText,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text(statusDescription,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, size: 50),
            const SizedBox(width: 20),
          ],
        ));
  }
}

// stful
class IdentityCard extends StatelessWidget {
  const IdentityCard(
      {super.key, required this.isVerified, required this.address});
  final bool isVerified;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, -0.06),
            end: Alignment(-1, 0.06),
            colors: [
              Color.fromARGB(255, 20, 82, 95),
              Color.fromARGB(255, 35, 79, 68)
            ],
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 5, color: Colors.blue.shade400),
              borderRadius: BorderRadius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Text("Indian Digital Identity Card",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
            const SizedBox(height: 10),
            Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 1,
                width: double.infinity),
            const SizedBox(height: 10),
            Row(children: [
              const SizedBox(width: 15),
              const Text("NAME: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
              Text(Global.userName ?? "Invalid Username",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
              const Spacer(),
              const Text("DOB: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
              const Text("13/06/2004",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
            ]),
            const Spacer(),
            Text(
              "${Global.userId}",
              style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow.shade600),
            ),
            const SizedBox(height: 10),
            Center(
                child: Text(
                    isVerified ? "Digitaly Verified" : "Pending Verification",
                    style: const TextStyle(color: Colors.grey, fontSize: 12))),
            const SizedBox(height: 5),
            SelectableText(
              address,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 9,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ));
  }
}

// class ElectionsSelector extends StatefulWidget {
//   // const ElectionsSelector({super.key, required this.elections});
//   // final List<Elections> elections;
//   @override
//   State<ElectionsSelector> createState() => _ElectionsSelectorState();
// }

// class _ElectionsSelectorState extends State<ElectionsSelector> {
//   // List<Elections> elections = [];
//   int selected = -1;
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const Text(
//         "Send Request to participate in elections",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       SizedBox(
//           child: DropdownButton(
//               hint: Text(selected == -1
//                   ? "Select Election"
//                   : widget.elections[selected - 1].name),
//               items: () {
//                 List<DropdownMenuItem> items = [
//                   // DropdownMenuItem(
//                   //   child: Text("Select Item"),
//                   //   value: 0,
//                   // )
//                 ];
//                 items.addAll(widget.elections.map((e) => DropdownMenuItem(
//                       value: e.id.toInt(),
//                       child: Text(e.name),
//                     )));
//                 return items;
//               }(),
//               onChanged: (value) {
//                 if (selected != value) {
//                   setState(() {
//                     selected = value;
//                   });
//                 }
//               })),
//       TextButton(
//           onPressed: () {
//             if (selected != -1) {
//               // Global.linker.requestToParticipate(3, selected);
//             }
//           },
//           child: Text((selected == -1)
//               ? "Choose election"
//               : "Request to participate in ${widget.elections[selected - 1].name}"))
//     ]);
//   }
// }
