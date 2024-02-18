import 'package:flutter/material.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/pages/home/home.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class Elections extends StatefulWidget {
  const Elections({super.key});

  @override
  State<Elections> createState() => _ElectionsState();
}

class _ElectionsState extends State<Elections> {
  String address = "";
  String balance = "";
  bool isVerified = false;
  List<apiTypes.Election> upcomingElections = [];
  List<apiTypes.Election> ongoingElections = [];
  late Future<void> loader;
  @override
  void initState() {
    super.initState();
    loader = init();
  }

  Future<void> init() async {
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
        VoterHelper().isVoted(el.id).then((value) {
          el.isVoted = value;
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
          future: loader,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
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
                                            candidates: 0,
                                          ))
                                      .toList();
                                  elections.addAll(
                                      upcomingElections.map((e) => ElectionCard(
                                            election: e,
                                            candidates: 0,
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
