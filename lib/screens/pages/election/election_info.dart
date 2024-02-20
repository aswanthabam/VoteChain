import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vote/screens/pages/election/candidate_profile.dart';
import 'package:vote/screens/pages/election/candidate_vote_page.dart';
import 'package:vote/screens/pages/home/home.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/buttons/fullsize_action_button/full_size_action_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/api/election.dart';
import 'package:vote/services/api/location/location.dart';
import 'package:vote/services/blockchain/candidate_helper.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class ElectionInfo extends StatefulWidget {
  final apiTypes.Election election;
  const ElectionInfo({super.key, required this.election});

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String constituencyImage =
      "https://raw.githubusercontent.com/aswanthabam/VoteChain/3ea448dfce18f2c73464d0d9a49315cb778258ec/src/images/asset/Frame%202.png";
  apiTypes.Constituency? constituency;
  apiTypes.CandidateProfile? candidateProfile;
  List<CandidateInfo> candidateInfo = [];
  List<apiTypes.Result> results = [];
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
      CandidateHelper().getEligibleCandidates(widget.election.id).then((value) {
        candidateInfo = value;
        setState(() {});
      });
      if (widget.election.resultsPublished) {
        VoterHelper().getResults(widget.election.id).then((value) {
          results = value ?? [];
          results.sort((a, b) => a.votes.compareTo(b.votes));
          setState(() {});
        });
      }
      setState(() {});
      return true;
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                                  height: 200,
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
                                                  backgroundColor: Colors.white,
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
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.cover),
                                                  )),
                                                  icon2: Row(
                                                    children: [
                                                      ClipOval(
                                                          child: Image.network(
                                                        apiTypes.SystemConfig
                                                                .localServer +
                                                            (e.profile.logo),
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit
                                                                    .cover),
                                                      )),
                                                      const SizedBox(width: 3),
                                                      const Icon(
                                                        Icons.chevron_right,
                                                        size: 35,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
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
                                                        Text(
                                                          e.profile.party.name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ]),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        _scaffoldKey
                                                            .currentContext!,
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
                                      underlineColor: Colors.green,
                                      underlineWidth: 100,
                                      underlineHeight: 4),
                                  Row(children: [
                                    Flexible(
                                        child: Text(
                                      constituency?.description ?? '',
                                      style: const TextStyle(fontSize: 13),
                                    ))
                                  ]),
                                  (widget.election.isEnded &&
                                          widget.election.resultsPublished)
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const UnderlinedText(
                                                heading: "Result",
                                                fontSize: 20,
                                                color: Colors.black,
                                                underlineColor: Colors.green,
                                                underlineWidth: 70,
                                                underlineHeight: 4),
                                            Column(
                                                children: results.map((e) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: () {
                                                  if (candidateInfo.isEmpty) {
                                                    return const SizedBox(
                                                      height: 0,
                                                    );
                                                  }
                                                  var rank =
                                                      results.indexOf(e) + 1;
                                                  var candidate = candidateInfo
                                                      .where((element) =>
                                                          element.info.address
                                                              .hex ==
                                                          e.candidateAddress
                                                              .hex)
                                                      .first;
                                                  Global.logger.f(
                                                      "Candidate : ${candidate.profile.name}, rank : $rank");
                                                  return FullSizeActionButton(
                                                      backgroundColor: rank == 1
                                                          ? const Color.fromARGB(
                                                                  255,
                                                                  209,
                                                                  132,
                                                                  55)
                                                              .withAlpha(100)
                                                          : rank == 2
                                                              ? const Color.fromARGB(
                                                                  255,
                                                                  141,
                                                                  213,
                                                                  145)
                                                              : rank == 3
                                                                  ? const Color.fromARGB(
                                                                      255,
                                                                      154,
                                                                      198,
                                                                      234)
                                                                  : const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      139,
                                                                      131,
                                                                      131),
                                                      icon: ClipOval(
                                                          child: Image.network(
                                                        apiTypes.SystemConfig
                                                                .localServer +
                                                            (candidate.profile
                                                                    .photo ??
                                                                ''),
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit
                                                                    .cover),
                                                      )),
                                                      icon2: Text(
                                                        e.votes.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      text: "text",
                                                      textWidget: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              candidate
                                                                  .profile.name,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                                height: 6),
                                                            Text(
                                                              candidate.profile
                                                                  .party.name,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            )
                                                          ]),
                                                      onPressed: () {});
                                                }(),
                                              );
                                            }).toList())
                                          ],
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ),
                                  const SizedBox(height: 20),
                                  widget.election.isOnGoing ||
                                          widget.election.isEnded
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const UnderlinedText(
                                              heading: "Statistics",
                                              fontSize: 18,
                                              color: Colors.black,
                                              underlineColor: Colors.green,
                                              underlineWidth: 100,
                                              underlineHeight: 4,
                                            ),
                                            Row(
                                              children: [
                                                TextBadge(
                                                  heading:
                                                      "Total Voting percentage",
                                                  value:
                                                      "${NumberFormat("##.##").format(widget.election.votes / widget.election.voterCount * 100)} %",
                                                  background: Colors
                                                      .blue.shade400
                                                      .withAlpha(100),
                                                  height: 75,
                                                ),
                                                TextBadge(
                                                  heading: "Total Voters",
                                                  value:
                                                      '${widget.election.voterCount}',
                                                  background: Colors
                                                      .green.shade400
                                                      .withAlpha(100),
                                                  height: 75,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                UnderlinedText(
                                                  heading: "Voting Trend",
                                                  fontSize: 13,
                                                  color: Colors.blueGrey,
                                                  underlineColor: Colors.grey,
                                                  underlineWidth: 50,
                                                  underlineHeight: 4,
                                                  center: true,
                                                )
                                              ],
                                            ),
                                            ElectionVoteChart(
                                                election: widget.election)
                                          ],
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  widget.election.isVoted
                      ? SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: getMinimalAsyncButton(context, () async {
                            return true;
                          },
                              "You've Already Voted",
                              "You've Already Voted",
                              "You've Already Voted",
                              "You've Already Voted",
                              Colors.grey,
                              Colors.white,
                              MediaQuery.of(context).size.width),
                        )
                      : widget.election.isOnGoing
                          ? SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: getPrimaryAsyncButton(context, () async {
                                _showCandidateSelectDialog();
                                return true;
                              },
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
                                  child: getMinimalAsyncButton(context,
                                      () async {
                                    return true;
                                  },
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

  void _showCandidateSelectDialog() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select Candidate",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "Please select the candidate you want to vote for, you can also click on the view info to view more information about the candidate"),
                    const SizedBox(
                      height: 20,
                    ),
                    candidateInfo.isNotEmpty
                        ? Column(
                            children: candidateInfo
                                .map((e) => FullSizeActionButton(
                                    showShadow: true,
                                    icon: ClipOval(
                                        child: Image.network(
                                      apiTypes.SystemConfig.localServer +
                                          (e.profile.photo ?? ''),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset(
                                              'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover),
                                    )),
                                    icon2: Row(
                                      children: [
                                        ClipOval(
                                            child: Image.network(
                                          apiTypes.SystemConfig.localServer +
                                              (e.profile.logo),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Image.asset(
                                                  'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover),
                                        )),
                                        const Icon(
                                          Icons.content_paste_go_rounded,
                                          size: 25,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    text: e.profile.name,
                                    textWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.profile.name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            e.profile.party.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ]),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CandidateVotePage(
                                                    info: e,
                                                    election: widget.election,
                                                  )));
                                    }))
                                .toList(),
                          )
                        : const Center(
                            child: Text(
                                "No candidates registered yet. Please look back later"),
                          ),
                  ],
                ))));
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
            SizedBox(
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

class ElectionVoteChart extends StatefulWidget {
  const ElectionVoteChart({super.key, required this.election});
  final apiTypes.Election election;

  @override
  State<ElectionVoteChart> createState() => _ElectionVoteChartState();
}

class _ElectionVoteChartState extends State<ElectionVoteChart> {
  List<ElectionStatisticsTime> stats = [];
  @override
  void initState() {
    super.initState();
    Global.logger.f(
        "Election start date : ${widget.election.startDate}, end date : ${widget.election.endDate}");
    ElectionCall()
        .getElectionStatisticsTime(
            electionId: widget.election.id.toString(),
            startTime: DateTime.now().subtract(const Duration(days: 1)),
            endTIme: DateTime.now())
        .then((value) {
      Global.logger.f("Election statistics : $value");
      stats = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        plotAreaBackgroundColor: Colors.grey.shade100,
        zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            enableDoubleTapZooming: true,
            enableSelectionZooming: true),
        primaryYAxis: const NumericAxis(
          isVisible: false,
          labelStyle: TextStyle(fontSize: 10, color: Colors.green),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryXAxis: DateTimeAxis(
            interval: 1,
            labelRotation: 90,
            labelStyle: const TextStyle(fontSize: 10, color: Colors.green),
            dateFormat: DateFormat('hh a'),
            majorGridLines: const MajorGridLines(width: 0)),
        series: <CartesianSeries<ElectionStatisticsTime, DateTime>>[
          // Renders column chart
          ColumnSeries<ElectionStatisticsTime, DateTime>(
              name: 'Votes',
              width: 1,
              dataSource: stats,
              color: Colors.orange.shade400,
              enableTooltip: true,
              animationDuration: 1000,
              xValueMapper: (ElectionStatisticsTime data, _) => data.time,
              yValueMapper: (ElectionStatisticsTime data, _) => data.votes)
        ]);
  }
}
