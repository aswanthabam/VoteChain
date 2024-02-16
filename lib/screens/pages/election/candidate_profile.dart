import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/content_views/table/table_view.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/services/blockchain/candidate_helper.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateProfilePage extends StatelessWidget {
  const CandidateProfilePage({super.key, required this.info});
  final CandidateInfo info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
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
                bottom: 10,
                left: 10,
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      SystemConfig.localServer + (info.profile.photo ?? ""),
                      fit: BoxFit.fitWidth,
                    )),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.profile.name,
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          info.profile.party.name,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            SystemConfig.localServer + info.profile.party.logo,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitWidth))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                UnderlinedText(
                    heading: "About Me",
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    underlineColor: Colors.green,
                    underlineWidth: 100,
                    underlineHeight: 4),
                Text(
                    info.profile.about ?? "No about provided by the candidate"),
                const SizedBox(
                  height: 10,
                ),
                UnderlinedText(
                    heading: "Education",
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    underlineColor: Colors.green,
                    underlineWidth: 100,
                    underlineHeight: 4),
                TableView<Education>(
                  data: info.profile.education,
                  getRow: (e) => {
                    "title": e.title,
                    "fromWhere": e.fromWhere,
                    "description": e.description
                  },
                  columnNames: const [
                    'Qualification',
                    'Institutue',
                    'Description'
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                UnderlinedText(
                    heading: "Experience",
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    underlineColor: Colors.green,
                    underlineWidth: 100,
                    underlineHeight: 4),
                TableView<Education>(
                  data: info.profile.education,
                  getRow: (e) => {
                    "title": e.title,
                    "fromWhere": e.fromWhere,
                    "description": e.description
                  },
                  columnNames: const ['Name', 'From', 'Description'],
                ),
                const SizedBox(
                  height: 10,
                ),
                UnderlinedText(
                    heading: "Documents",
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    underlineColor: Colors.green,
                    underlineWidth: 100,
                    underlineHeight: 4),
                const Text("Click on the document to view it."),
                const SizedBox(height: 10),
                Column(
                  children: info.profile.documents
                      .map((e) => DocumentCard(
                          title: e.title,
                          link: SystemConfig.localServer + e.link))
                      .toList(),
                )
              ],
            ))
      ]),
    ));
  }
}

class DocumentCard extends StatelessWidget {
  final String title;
  final String link;

  const DocumentCard({super.key, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView)
            .then((value) {
          if (!value) {
            showDialog(
                context: context,
                builder: (context) => TextPopup(
                      message:
                          "Unable to open the link. Please try again later.",
                      bottomButtons: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Continue"))
                      ],
                    ));
          }
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.file_present_outlined,
                size: 30, color: Colors.blue)
          ],
        ),
      ),
    );
  }
}
