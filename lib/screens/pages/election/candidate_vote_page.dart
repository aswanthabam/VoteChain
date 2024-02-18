import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote/screens/pages/election/candidate_profile.dart';
import 'package:vote/screens/pages/election/vote_cast_result.dart';
import 'package:vote/screens/pages/face_verification/face_verification.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/services/blockchain/candidate_helper.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class CandidateVotePage extends StatefulWidget {
  const CandidateVotePage(
      {super.key, required this.info, required this.election});
  final CandidateInfo info;
  final apiTypes.Election election;

  @override
  State<CandidateVotePage> createState() => _CandidateVotePageState();
}

class _CandidateVotePageState extends State<CandidateVotePage> {
  bool voteCasted = false;
  bool voteCastingFailed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackBar(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: const Color.fromARGB(255, 94, 198, 177)),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipOval(
                          child: Image.network(
                        apiTypes.SystemConfig.localServer +
                            (widget.info.profile.photo ?? ''),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                            'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.info.profile.name,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 3,
                                offset: const Offset(0, 3))
                          ]),
                      child: Row(
                        children: [
                          ClipOval(
                              child: Image.network(
                            apiTypes.SystemConfig.localServer +
                                (widget.info.profile.logo),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                    'src/images/asset/user-person-profile-block-account-circle-svgrepo-com.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover),
                          )),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Candidate of: ",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.green[300]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.info.profile.party.name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.info.profile.about ?? "No description available",
                      maxLines: 5,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CandidateProfilePage(
                                              info: widget.info)));
                            },
                            child: const Text("View Profile")),
                      ],
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri(
                                    scheme: 'tel',
                                    path: '${widget.info.profile.phone}'),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.phone_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    widget.info.profile.phone ??
                                        "No phone provided",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri(
                                    scheme: 'mailto',
                                    path: '${widget.info.profile.email}'),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    widget.info.profile.email ??
                                        "No email provided",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 80,
                                child: Text(
                                  widget.info.profile.address ??
                                      "No address provided",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getPrimaryAsyncButton(context, () async {
              showDialog(
                  context: context,
                  builder: (context) => TextPopup(
                        message:
                            "Are you sure you want to vote for ${widget.info.profile.name}?",
                        bottomButtons: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FaceVerificationPage(
                                              onVerificationComplete: (bool sts,
                                                  CameraDetectionController
                                                      detectionController) {
                                                if (sts) {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) =>
                                                          VoteCastResultDialog(
                                                              candidateAddress:
                                                                  widget
                                                                      .info
                                                                      .info
                                                                      .address,
                                                              electionId: widget
                                                                  .election
                                                                  .id));
                                                }
                                              },
                                            )));
                              },
                              child: const Text(
                                "I Confirm",
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"))
                        ],
                      )).then((value) async {});
              return true;
            }, "Cast Vote", "Cast Vote", "Cast Vote", "Cast Vote",
                MediaQuery.of(context).size.width)
          ],
        ));
  }
}
