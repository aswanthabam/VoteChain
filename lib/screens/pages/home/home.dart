import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote/contracts/VoteChain.g.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/pages/election/election_info.dart';
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
                      const SizedBox(height: 20),
                      const UnderlinedText(
                          heading: "Elections",
                          fontSize: 20,
                          color: Colors.black,
                          underlineColor: Colors.black,
                          underlineWidth: 100,
                          underlineHeight: 8),
                      Column(
                        children: () {
                          var elections = ongoingElections
                              .map<Widget>((e) => ElectionCard(
                                    election: e,
                                    electionStatus: true,
                                    candidates: 0,
                                  ))
                              .toList();
                          elections
                              .addAll(upcomingElections.map((e) => ElectionCard(
                                    election: e,
                                    electionStatus: false,
                                    candidates: 0,
                                  )));
                          var no_elections = [
                            Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(19),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "No Elections Available now!",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]))
                          ];
                          return elections.isNotEmpty
                              ? elections
                              : no_elections;
                        }(),
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

class ElectionCard extends StatelessWidget {
  final apiTypes.Election election;
  final bool electionStatus;
  final int? nominations;
  final int candidates;
  final double? percentage;
  const ElectionCard(
      {super.key,
      required this.election,
      this.electionStatus = false,
      required this.candidates,
      this.nominations,
      this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(19),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextIconBadge(
              text: electionStatus ? "Ongoing" : "Upcoming",
              icon: const Icon(
                Icons.access_time,
                size: 17,
              ),
              bgColor: electionStatus
                  ? const Color(0xB243F034)
                  : const Color(0xFFDFEA67)),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                election.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextBadge(
                  heading: "Starts at",
                  value:
                      DateFormat("dd MMM HH:MM a").format(election.startDate),
                  background: const Color(0xFF67EACA)),
              TextBadge(
                  heading: "Ends on",
                  value: DateFormat("dd MMM HH:MM a").format(election.endDate),
                  background: const Color(0xFF54CFF6)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          electionStatus
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBadge(
                        heading: "Total Candidates",
                        value: candidates.toString(),
                        background: const Color(0xFFE5B9FA),
                        valueFontsize: 20),
                    TextBadge(
                        heading: "Voting Percentage",
                        value: (percentage ?? 0).toString(),
                        background: const Color(0xFFFDDFC3),
                        valueFontsize: 20),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBadge(
                        heading: "Total Nominations",
                        value: (nominations ?? 0).toString(),
                        background: const Color(0xFFFDDFC3),
                        valueFontsize: 20),
                    TextBadge(
                        heading: "Total Candidates",
                        value: candidates.toString(),
                        background: const Color(0xFFE5B9FA),
                        valueFontsize: 20),
                  ],
                ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ElectionInfo(election: election)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: ShapeDecoration(
                      color: const Color(0x281BA68D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Learn More',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class TextIconBadge extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color textColor;
  final Color bgColor;
  const TextIconBadge(
      {super.key,
      required this.text,
      required this.icon,
      required this.bgColor,
      this.textColor = const Color(0xFF7D7777)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.access_time_sharp,
            size: 17,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class TextBadge extends StatelessWidget {
  final String heading;
  final String value;
  final Color background;
  final Color textColor;
  final double headingFontsize;
  final double valueFontsize;

  const TextBadge(
      {super.key,
      required this.heading,
      required this.value,
      required this.background,
      this.textColor = Colors.black,
      this.headingFontsize = 13,
      this.valueFontsize = 15});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(heading,
              style: TextStyle(
                  color: textColor,
                  fontSize: headingFontsize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0)),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: valueFontsize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ],
      ),
    ));
  }
}

// class IdentityCard extends StatelessWidget {
//   const IdentityCard(
//       {super.key, required this.isVerified, required this.address});
//   final bool isVerified;
//   final String address;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 200,
//         padding: const EdgeInsets.all(20),
//         decoration: ShapeDecoration(
//           gradient: const LinearGradient(
//             begin: Alignment(1.00, -0.06),
//             end: Alignment(-1, 0.06),
//             colors: [
//               Color.fromARGB(255, 20, 82, 95),
//               Color.fromARGB(255, 35, 79, 68)
//             ],
//           ),
//           shape: RoundedRectangleBorder(
//               side: BorderSide(width: 5, color: Colors.blue.shade400),
//               borderRadius: BorderRadius.circular(20)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Center(
//                 child: Text("Indian Digital Identity Card",
//                     style: TextStyle(color: Colors.white, fontSize: 12))),
//             const SizedBox(height: 10),
//             Container(
//                 decoration: const BoxDecoration(color: Colors.white),
//                 height: 1,
//                 width: double.infinity),
//             const SizedBox(height: 10),
//             Row(children: [
//               const SizedBox(width: 15),
//               const Text("NAME: ",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12)),
//               Text(Global.userName ?? "Invalid Username",
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12)),
//               const Spacer(),
//               const Text("DOB: ",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12)),
//               const Text("13/06/2004",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12)),
//             ]),
//             const Spacer(),
//             Text(
//               "${Global.userId}",
//               style: TextStyle(
//                   letterSpacing: 5,
//                   fontSize: 25,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.yellow.shade600),
//             ),
//             const SizedBox(height: 10),
//             Center(
//                 child: Text(
//                     isVerified ? "Digitaly Verified" : "Pending Verification",
//                     style: const TextStyle(color: Colors.grey, fontSize: 12))),
//             const SizedBox(height: 5),
//             SelectableText(
//               address,
//               maxLines: 1,
//               style: const TextStyle(
//                   color: Colors.white60,
//                   fontSize: 9,
//                   overflow: TextOverflow.ellipsis),
//             ),
//           ],
//         ));
//   }
// }
