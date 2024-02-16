import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote/screens/pages/election/candidate_profile.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/buttons/fullsize_action_button/full_size_action_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/api/location/location.dart';
import 'package:vote/services/blockchain/candidate_helper.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class ElectionInfo extends StatefulWidget {
  final apiTypes.Election election;
  const ElectionInfo({super.key, required this.election});

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  String constituencyImage =
      "https://raw.githubusercontent.com/aswanthabam/VoteChain/3ea448dfce18f2c73464d0d9a49315cb778258ec/src/images/asset/Frame%202.png";
  apiTypes.Constituency? constituency;
  apiTypes.CandidateProfile? candidateProfile;
  List<CandidateInfo> candidateInfo = [];
  late Future<bool> loader;
  @override
  void initState() {
    super.initState();
    loader = () async {
      constituencyImage = await LocationCall()
              .getConstituencies(constituencyId: widget.election.constituency)
              .then((value) {
            constituency = value[0];
            return value[0].image;
          }) ??
          constituencyImage;
      constituencyImage = constituencyImage.startsWith('http')
          ? constituencyImage
          : "https:$constituencyImage";
      CandidateHelper()
          .getEligibleCandidates((int.parse(widget.election.id)))
          .then((value) {
        candidateInfo = value;
        setState(() {});
      });
      setState(() {});
      return true;
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: loader,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 70,
                    // margin: const EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        constituencyImage,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  )),
                              Positioned(
                                  top: 0,
                                  width: MediaQuery.of(context).size.width,
                                  child: BackBar(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    background: Colors.black.withAlpha(30),
                                    height: AppBar().preferredSize.height + 10,
                                  )),
                              Positioned(
                                  top: 100,
                                  width: MediaQuery.of(context).size.width - 30,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.election.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width)
                            ],
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const UnderlinedText(
                                  //     heading: "About Election",
                                  //     fontSize: 20,
                                  //     color: Colors.black,
                                  //     underlineColor: Colors.green,
                                  //     underlineWidth: 100,
                                  //     underlineHeight: 4),
                                  AboutElectionCard(info: widget.election),
                                  const UnderlinedText(
                                      heading: "Candidates",
                                      fontSize: 20,
                                      color: Colors.black,
                                      underlineColor: Colors.green,
                                      underlineWidth: 100,
                                      underlineHeight: 4),
                                  candidateInfo.isNotEmpty
                                      ? Column(
                                          children: candidateInfo
                                              .map((e) => FullSizeActionButton(
                                                  showShadow: true,
                                                  icon: ClipOval(
                                                      child: Image.network(
                                                    apiTypes.SystemConfig
                                                            .localServer +
                                                        (e.profile.photo ?? ''),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                            'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                                            width: 90,
                                                            height: 90,
                                                            fit: BoxFit.cover),
                                                  )),
                                                  icon2: ClipOval(
                                                      child: Image.network(
                                                    apiTypes.SystemConfig
                                                            .localServer +
                                                        (e.profile.logo),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                            'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                                            width: 90,
                                                            height: 90,
                                                            fit: BoxFit.cover),
                                                  )),
                                                  text: e.profile.name,
                                                  textWidget: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.profile.name,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(e
                                                            .profile.party.name)
                                                      ]),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CandidateProfilePage(
                                                                  info: e,
                                                                )));
                                                  }))
                                              .toList(),
                                        )
                                      : const Center(
                                          child: Text(
                                              "No candidates registered yet. Please look back later"),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const UnderlinedText(
                                      heading: "About the constituency",
                                      fontSize: 18,
                                      color: Colors.black,
                                      underlineColor: Colors.black,
                                      underlineWidth: 100,
                                      underlineHeight: 4),
                                  Row(children: [
                                    Flexible(
                                        child: Text(
                                      constituency?.description ?? '',
                                      style: const TextStyle(fontSize: 16),
                                    ))
                                  ]),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  widget.election.isOnGoing
                      ? SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: getPrimaryAsyncButton(
                              context,
                              () async => true,
                              "Cast Your Vote",
                              "Cast Your Vote",
                              "Cast Your Vote",
                              "Cast Your Vote",
                              MediaQuery.of(context).size.width),
                        )
                      : (widget.election.isEnded
                          ? SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: getMinimalAsyncButton(
                                  context,
                                  () async => true,
                                  "Election Ended",
                                  "Election Ended",
                                  "Election Ended",
                                  "Election Ended",
                                  Colors.grey,
                                  Colors.white,
                                  MediaQuery.of(context).size.width),
                            )
                          : SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: getMinimalAsyncButton(
                                  context,
                                  () async => true,
                                  "Election Not Started",
                                  "Election Not Started",
                                  "Election Not Started",
                                  "Election Not Started",
                                  Colors.grey,
                                  Colors.white,
                                  MediaQuery.of(context).size.width),
                            ))
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class AboutElectionCard extends StatelessWidget {
  const AboutElectionCard({super.key, required this.info});
  final apiTypes.Election info;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 241, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(255, 99, 98, 98).withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 1)
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                const Icon(
                  Icons.notifications_none,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                        text: TextSpan(
                            text: info.isOnGoing
                                ? "Election will end on "
                                : info.isEnded
                                    ? "Election ended on "
                                    : "Election will start on ",
                            style: DefaultTextStyle.of(context).style,
                            children: [
                      TextSpan(
                          text: DateFormat('dd MMMM y, h:m a')
                              .format(info.isOnGoing
                                  ? info.endDate
                                  : info.isEnded
                                      ? info.endDate
                                      : info.startDate),
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ])))
              ]))
        ]));
  }
}

class CandidateCard extends StatelessWidget {
  const CandidateCard({super.key, required this.info});
  final CandidateInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: FullSizeActionButton(
                  icon: ClipOval(
                      child: Image.network(
                    apiTypes.SystemConfig.localServer +
                        (info.profile.photo ?? ''),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover),
                  )),
                  icon2: const Icon(Icons.chevron_right_outlined),
                  text: info.profile.name,
                  onPressed: () {}),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.blue, width: 2),
            //       borderRadius: BorderRadius.circular(100)),
            //   child: ClipOval(
            //     child: Image.network(
            //       apiTypes.SystemConfig.localServer +
            //           (info.profile.photo ?? ''),
            //       width: 50,
            //       height: 50,
            //       fit: BoxFit.cover,
            //       errorBuilder: (context, error, stackTrace) => Image.asset(
            //           'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
            //           width: 90,
            //           height: 90,
            //           fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.profile.name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  info.profile.party.name,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 220,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AsyncButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CandidateProfilePage(
                                      info: info,
                                    )));
                        return true;
                      },
                      primaryBackground:
                          const Color.fromARGB(255, 109, 178, 235),
                      primaryTextColor: const Color.fromARGB(255, 34, 34, 35),
                      loadingBackground:
                          const Color.fromARGB(255, 109, 178, 235),
                      loadingTextColor: const Color.fromARGB(255, 34, 34, 35),
                      failedTextColor: const Color.fromARGB(255, 34, 34, 35),
                      failedBackground:
                          const Color.fromARGB(255, 109, 178, 235),
                      successBackground:
                          const Color.fromARGB(255, 109, 178, 235),
                      successTextColor: const Color.fromARGB(255, 34, 34, 35),
                      progressBarColor: const Color.fromARGB(255, 34, 34, 35),
                      primaryText: "View Profile",
                      loadingText: "View Profile",
                      failedText: "View Profile",
                      successText: "View Profile",
                      width: MediaQuery.of(context).size.width - 220,
                      padding: 5,
                      fontSize: 13,
                      height: 30,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
