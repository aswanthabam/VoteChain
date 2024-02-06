// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/progress_bar/radial_progress.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;
import 'package:http/http.dart' as http;

class FaceVerificationPage extends StatefulWidget {
  const FaceVerificationPage({super.key});
  @override
  State<FaceVerificationPage> createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage> {
  late CameraDetectionController detectionController;
  int totalImages = 0;
  int totalNeededImages = 15;

  List<Color> gradientColors = const [
    Color(0xffFF0069),
    Color(0xffFED602),
    Color(0xff7639FB),
    Color(0xffD500C5),
    Color(0xffFF7A01),
    Color(0xffFF0069),
  ];

  @override
  void initState() {
    super.initState();
    detectionController = CameraDetectionController(onImage: onImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackBar(onPressed: () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UnderlinedText(
                      heading: "Verifiy Your Face",
                      fontSize: 30,
                      color: Color.fromARGB(255, 3, 43, 5),
                      underlineColor: Colors.green,
                      underlineWidth: 200,
                      underlineHeight: 5),
                  const Text(
                      "Please make sure that your face is clear and you are in a plain background."),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        child: CustomPaint(
                            painter: RadialProgressPainter(
                                value: totalImages / totalNeededImages,
                                backgroundGradientColors: gradientColors,
                                minValue: 0,
                                maxValue: 1,
                                width: MediaQuery.of(context).size.width,
                                height: 350)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        child: CameraApp(controller: detectionController),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void startRecapture() {}

  Future<void> onImage(File file) async {
    final String? uid = (VoterHelper.voterInfo == null ||
            VoterHelper.voterInfo!.aadharNumber.isEmpty)
        ? null
        : VoterHelper.voterInfo?.aadharNumber;
    if (uid == null) {
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                message: "Error: User not found",
                bottomButtons: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Continue"))
                ],
              ));
      return;
    }
    if (totalImages < totalNeededImages) {
      (bool, bool) res =
          await sendImageToApi(file, uid, context); // face found, result
      totalImages++;
      if (res.$1) {
        if (res.$2) {
          detectionController.stopCapturing();
          totalImages = totalNeededImages;
          showDialog(
              context: context,
              builder: (context) => TextPopup(
                    message:
                        "Gotchu!! Successfully verified you, you are the we are looking for!",
                    bottomButtons: [
                      TextButton(
                          onPressed: () {
                            detectionController.controller?.dispose();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Continue, and go back"))
                    ],
                  ));
        }
      } else {
        // send a message to move a little bit
      }

      setState(() {});
    } else {
      detectionController.stopCapturing();
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                message:
                    "Oops! Seems like you are not the one we are looking for!",
                bottomButtons: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        detectionController.recapture();
                        totalImages = 0;
                        setState(() {});
                      },
                      child: const Text("Try Again")),
                  TextButton(
                      onPressed: () {
                        detectionController.controller?.dispose();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Back"))
                ],
              )).then((value) {
        detectionController.controller?.dispose();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
  }

  Future<(bool, bool)> sendImageToApi(
      File imageFile, String uid, BuildContext context) async {
    try {
      final url = "${apiTypes.SystemConfig.localServer}/api/user/face/verify/";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('face', imageFile.path));

      request.fields['uid'] = uid;
      var response = await request.send();
      print("UID : $uid");
      String resString = await response.stream.bytesToString();
      print(resString);
      Map<String, dynamic> res = jsonDecode(resString);
      if (response.statusCode == 200) {
        Global.logger.i("Image successfully sent to the API");
        bool face_found = res['data']['face_found'];
        if (face_found) {
          return (face_found, res['data']['result'] as bool);
        } else {
          return (false, false);
        }
      } else {
        Global.logger.w(
            "Failed to send image to the API. Status code: ${response.statusCode}");
        return (false, false);
      }
    } catch (e) {
      Global.logger.e("Error sending image to API: $e");
      return (false, false);
    }
  }
}
