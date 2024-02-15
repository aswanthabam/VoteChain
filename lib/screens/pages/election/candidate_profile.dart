import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/content_views/table/table_view.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/candidate_helper.dart';
import 'package:vote/utils/types/api_types.dart';

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
                decoration: BoxDecoration(
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
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
              ],
            ))
      ]),
    ));
  }
}
