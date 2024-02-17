import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/pages/election/election_info.dart';
import 'package:vote/screens/widgets/content_views/card/card.dart';
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
  late Future<void> initializationWaiter;
  @override
  void initState() {
    super.initState();
    initializationWaiter = init();
  }

  Future<void> init() async {
    status =
        await VoterHelper().fetchRegistrationStatus() ?? VoterStatus.registered;
    await VoterHelper().fetchInfo();
    Contracts.votechain
        ?.getUpComingElections$2(VoterHelper.voterInfo?.constituency ?? "")
        .then((value) {
      Global.logger.d("Upcoming elections: $value");
      upcomingElections = value.map<apiTypes.Election>((e) {
        apiTypes.Election el = apiTypes.Election.fromList(e);
        VoterHelper().candidatesCount(el.id).then((value) {
          el.candidatesCount = value;
          setState(() {});
        });
        VoterHelper().totalVotersCount(el.constituency).then((value) {
          el.voterCount = value;
          setState(() {});
        });
        VoterHelper().totalNominations(el.id).then((value) {
          el.nominationCount = value;
          setState(() {});
        });
        return el;
      }).toList();
      setState(() {});
    });
    Contracts.votechain
        ?.getOnGoingElections(VoterHelper.voterInfo?.constituency ?? "")
        .then((value) {
      Global.logger.d("Ongoing elections: $value");
      ongoingElections = value.map<apiTypes.Election>((e) {
        apiTypes.Election el = apiTypes.Election.fromList(e);
        VoterHelper().candidatesCount(el.id).then((value) {
          el.candidatesCount = value;
          setState(() {});
        });
        VoterHelper().totalVotersCount(el.constituency).then((value) {
          el.voterCount = value;
          setState(() {});
        });
        VoterHelper().totalVotes(el.id).then((value) {
          el.votes = value;
          setState(() {});
        });
        return el;
      }).toList();
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayer(
      child: FutureBuilder(
          future: initializationWaiter,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox.expand(
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (status == VoterStatus.registered
                                ? const AccountStatusCard(
                                    statusText: "Not Verified",
                                    statusDescription:
                                        "Waiting for verification",
                                    status: false,
                                  )
                                : const CardWidget()),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: () {
                                  var elections =
                                      ongoingElections.map<Widget>((e) {
                                    return ElectionCard(
                                      election: e,
                                      candidates: e.candidatesCount,
                                      percentage: e.voterCount > 0
                                          ? (e.votes / e.voterCount * 100)
                                          : 100,
                                    );
                                  }).toList();
                                  elections.addAll(
                                      upcomingElections.map((e) => ElectionCard(
                                            election: e,
                                            candidates: e.candidatesCount,
                                            nominations: e.nominationCount,
                                          )));
                                  var no_elections = [
                                    Container(
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(19),
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]))
                                  ];
                                  List<Widget> res = [
                                    const UnderlinedText(
                                        heading: "Elections",
                                        fontSize: 20,
                                        color: Colors.black,
                                        underlineColor: Colors.black,
                                        underlineWidth: 100,
                                        underlineHeight: 8)
                                  ];
                                  res.addAll(elections.isNotEmpty
                                      ? elections
                                      : no_elections);
                                  return res;
                                }(),
                              ),
                            )
                          ],
                        ),
                      )),
                    )),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
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
            const SizedBox(width: 15),
            const Icon(Icons.info_outline, size: 40),
            const SizedBox(width: 15),
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
          ],
        ));
  }
}

class ElectionCard extends StatelessWidget {
  final apiTypes.Election election;
  final int? nominations;
  final int candidates;
  final double? percentage;

  const ElectionCard(
      {super.key,
      required this.election,
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
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
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
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextBadgeSecond(
                text:
                    "Election starts at ${DateFormat("dd MMM HH:MM a").format(election.startDate)}",
                icon: Icons.run_circle_outlined,
              ),
              const SizedBox(
                height: 10,
              ),
              TextBadgeSecond(
                text:
                    "Election ends on ${DateFormat("dd MMM HH:MM a").format(election.endDate)}",
                icon: Icons.timer_off_sharp,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          election.isOnGoing
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBadgeSecond(
                      text: "${(percentage ?? 0).toString()}% Voters Voted",
                      icon: Icons.analytics_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBadgeSecond(
                      text: "${(candidates).toString()} Total Candidates",
                      icon: Icons.person_sharp,
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBadgeSecond(
                      text:
                          "${(nominations ?? 0).toString()} Total Nominations",
                      icon: Icons.control_point_duplicate_sharp,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBadgeSecond(
                      text: "${(candidates).toString()} Total Candidates",
                      icon: Icons.person_sharp,
                    ),
                  ],
                ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextIconBadge(
                  text: election.isOnGoing
                      ? "Ongoing"
                      : election.isEnded
                          ? "Ended"
                          : "Upcoming",
                  icon: const Icon(
                    Icons.access_time,
                    size: 17,
                  ),
                  bgColor: election.isOnGoing
                      ? const Color(0xB243F034)
                      : election.isEnded
                          ? const Color(0xFFEA8867)
                          : const Color(0xFFDFEA67)),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ElectionInfo(election: election)));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Learn More >',
                      style: TextStyle(
                        color: Color.fromARGB(157, 67, 2, 114),
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

class TextBadgeSecond extends StatelessWidget {
  const TextBadgeSecond({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
        ),
        const SizedBox(width: 10),
        Text(text,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0)),
      ],
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
