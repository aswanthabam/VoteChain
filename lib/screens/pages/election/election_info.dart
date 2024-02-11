import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
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
                                  top: 165,
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
                                  height: 260,
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
                                  const UnderlinedText(
                                      heading: "Candidates",
                                      fontSize: 20,
                                      color: Colors.black,
                                      underlineColor: Colors.green,
                                      underlineWidth: 100,
                                      underlineHeight: 4),
                                  Column(
                                    children: candidateInfo
                                        .map((e) => CandidateCard(
                                              info: e,
                                            ))
                                        .toList(),
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
                  SizedBox(
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
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class CandidateCard extends StatelessWidget {
  const CandidateCard({super.key, required this.info});
  final CandidateInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
            ClipOval(
              child: Image.network(
                apiTypes.SystemConfig.localServer + (info.profile.photo ?? ''),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
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
                  "Education: ${info.profile.education.map((e) => e.title).join(', ')}",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Experience: ${info.profile.experience.map((e) => e.title).join(', ')}",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AsyncButton(
                      onPressed: () async {
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
                      width: MediaQuery.of(context).size.width - 200,
                      padding: 10,
                      fontSize: 13,
                      height: 40,
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
