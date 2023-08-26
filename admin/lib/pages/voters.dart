import 'package:admin/components/dialog.dart';
import 'package:flutter/material.dart';
import '../classes/global.dart';
import '../Election.g.dart';

class VotersWidget extends StatefulWidget {
  const VotersWidget({super.key});

  @override
  State<VotersWidget> createState() => _VotersWidgetState();
}

class _VotersWidgetState extends State<VotersWidget> {
  List<UserVerificationRequests> requests = [];
  List<UserParticipationRequests> participationRequests = [];
  @override
  void initState() {
    super.initState();
    Global.linker.getVotersToVerify(onError: () {
      showDialog(
          context: context,
          builder: (context) =>
              MsgDialog(text: "Unable to get voters to verify"));
    }).then((value) {
      setState(() {
        requests = value;
      });
    });
    Global.linker.getUserParticipationRequests(onError: () {
      showDialog(
          context: context,
          builder: (context) =>
              MsgDialog(text: "Unable to get Participation Requests"));
    }).then((value) {
      setState(() {
        participationRequests = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: requests.map((e) => VotersCard(request: e)).toList(),
            ),
            Column(
              children: participationRequests
                  .map((e) => VoterParticipationCard(request: e))
                  .toList(),
            ),
          ],
        ));
  }
}

class VotersCard extends StatelessWidget {
  VotersCard({super.key, required this.request});
  UserVerificationRequests request;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(40),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 130,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            request.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Request Id ",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Text(": ${request.uid}"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Status ", style: TextStyle(fontWeight: FontWeight.w700)),
              Text(request.verified
                  ? "Verified User"
                  : request.rejected
                      ? "Rejected User "
                      : "Verification Pending"),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Global.linker
                        .verifyUser(request.address, request.uid)
                        .then((val) {
                      if (val) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                MsgDialog(text: "Successfully verified"));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => MsgDialog(
                                text:
                                    "Verification Failed due to unknown reason"));
                      }
                    });
                  },
                  child: Text("Veify User")),
              TextButton(
                  onPressed: () {},
                  child: Text("Reject Request",
                      style: TextStyle(color: Colors.red)))
            ],
          )
        ]),
      ),
    );
  }
}

class VoterParticipationCard extends StatelessWidget {
  VoterParticipationCard({super.key, required this.request});
  UserParticipationRequests request;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(40),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 130,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "${request.uid}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Election Id ",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Text(": ${request.electionId}"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Status ", style: TextStyle(fontWeight: FontWeight.w700)),
              Text(request.accepted
                  ? "Accepted User"
                  : request.rejected
                      ? "Rejected User "
                      : "Request Pending"),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    // Global.linker.approveToVote(request., uid, electionId)
                    //     .then((val) {
                    //   if (val) {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) =>
                    //             MsgDialog(text: "Successfully verified"));
                    //   } else {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) => MsgDialog(
                    //             text:
                    //                 "Verification Failed due to unknown reason"));
                    //   }
                    // });
                  },
                  child: Text("Approve to vote")),
              TextButton(
                  onPressed: () {},
                  child: Text("Reject Request",
                      style: TextStyle(color: Colors.red)))
            ],
          )
        ]),
      ),
    );
  }
}
