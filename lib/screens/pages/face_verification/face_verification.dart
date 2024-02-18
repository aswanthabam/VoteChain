// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/progress_bar/radial_progress.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/global.dart';
import 'package:vote/services/utils.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;
import 'package:http/http.dart' as http;

class FaceVerificationPage extends StatefulWidget {
  const FaceVerificationPage({super.key, required this.onVerificationComplete});
  final void Function(bool, CameraDetectionController) onVerificationComplete;
  @override
  State<FaceVerificationPage> createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage>
    with WidgetsBindingObserver {
  late CameraDetectionController detectionController;
  int totalImages = 0;
  int totalNeededImages = 15;
  bool done = false;
  String message = "Please look at the camera and stay still.";
  late DateTime lastTime;
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

    WidgetsBinding.instance.addObserver(this);
    detectionController =
        CameraDetectionController(onImage: onImage, onMessage: setMessage);
    lastTime = DateTime.now();
  }

  @override
  void dispose() {
    detectionController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = detectionController
        .controller; // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      detectionController.recapture();
    }
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
              height: MediaQuery.of(context).size.height - 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const UnderlinedText(
                      heading: "Verifiy Your Face",
                      fontSize: 30,
                      color: Color.fromARGB(255, 3, 43, 5),
                      underlineColor: Colors.green,
                      underlineWidth: 0,
                      underlineHeight: 5),
                  const Text(
                    "Please make sure that your face is clear and you are in a plain background.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 40,
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
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 190, 91, 37)),
                      ))
                ],
              ),
            )));
  }

  void setMessage(String message) {
    if (DateTime.now().difference(lastTime).inSeconds < 2) return;
    this.message = message;
    setState(() {});
    lastTime = DateTime.now();
  }

  void startRecapture() {}

  Future<void> onImage(File file) async {
    if (done) return;
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
          done = true;
          await detectionController.stopCapturing();
          totalImages = totalNeededImages;
          widget.onVerificationComplete(true, detectionController);
        } else {
          // send a message to move a little bit
          setMessage("Its not the face im looking for, please try again.");
        }
      } else {
        // send a message to move a little bit
        setMessage("Your face is not clear, please move a little bit.");
      }

      setState(() {});
    } else {
      await detectionController.stopCapturing();
      done = true;
      widget.onVerificationComplete(false, detectionController);
      totalImages = 0;
    }
  }

  Future<(bool, bool)> sendImageToApi(
      File imageFile, String uid, BuildContext context) async {
    try {
      final url =
          "${apiTypes.SystemConfig.localServer}/api/user/face/verify/?APP_KEY=${await Utils.storage.read(key: 'app_key')}";
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
