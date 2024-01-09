import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/api/location/location.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;

class ElectionInfo extends StatefulWidget {
  final apiTypes.Election election;
  const ElectionInfo({super.key, required this.election});

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  String constituencyImage =
      "https://raw.githubusercontent.com/aswanthabam/Manager/master/app/src/main/res/drawable-hdpi/Banner.png";
  apiTypes.Constituency? constituency;
  @override
  void initState() {
    () async {
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
      // print(object)
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // margin: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: Column(
                  children: [
                    Image.network(
                      constituencyImage,
                      width: MediaQuery.of(context).size.width,
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
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: 260,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ])
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
