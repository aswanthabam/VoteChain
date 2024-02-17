// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/progress_bar/radial_progress.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/global.dart';
import 'package:vote/services/utils.dart';
import 'package:vote/utils/encryption.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;
import '../../../widgets/paginated_views/paginated_views.dart' as paging;
import 'package:http/http.dart' as http;

class FaceRegisterPage extends FormPage<String> {
  @override
  // ignore: overridden_fields
  String? validatedData;
  Function()? hideContinueButton;
  final String? Function() faceId;
  final String? Function() appKey;
  final Function() next;
  FaceRegisterPage(
      {this.hideContinueButton,
      required this.faceId,
      required this.next,
      required this.appKey});

  @override
  FormPageStatus validate() {
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    if (hideContinueButton != null) {
      hideContinueButton!();
    }
    return FaceRegisterWidget(
        pageState: this, faceId: faceId, next: next, appKey: appKey);
  }
}

class FaceRegisterWidget extends StatefulWidget {
  const FaceRegisterWidget(
      {super.key,
      required this.pageState,
      required this.faceId,
      required this.next,
      required this.appKey});

  final paging.PageState pageState;
  final Function() next;
  final String? Function() faceId;
  final String? Function() appKey;
  @override
  State<FaceRegisterWidget> createState() => _FaceRegisterWidgetState();
}

class _FaceRegisterWidgetState extends State<FaceRegisterWidget> {
  late CameraDetectionController detectionController;
  int totalImages = 0;
  int totalNeededImages = 3;
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
    widget.pageState.bindWidgetState(setState);
    detectionController =
        CameraDetectionController(onImage: onImage, onMessage: setMessage);
    lastTime = DateTime.now();
  }

  void setMessage(String message) {
    if (DateTime.now().difference(lastTime).inSeconds < 2) return;
    setState(() {
      this.message = message;
    });
    lastTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  heading: "Register Your Face",
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
        ));
  }

  void startRecapture() {}

  Future<void> onImage(File file) async {
    String? faceId = widget.faceId();
    if (faceId == null) {
      setMessage("Error getting face id");
      return;
    }
    if (totalImages < totalNeededImages - 1) {
      RegisterImageResponse res =
          await sendImageToApi(file, faceId, context, isFinal: false);
      if (res.status) {
        if (res.faceFound) {
          if (!res.matching) {
            setMessage("Face not matching, Please try again.");
          } else {
            totalImages++;
            setMessage("Its working... Please stay still.");
          }
        } else {
          setMessage("Your face is not clear, Please try again.");
        }
        setState(() {});
      } else {
        setMessage("Oops there is some issues, trying again.");
      }
    } else if (totalImages == totalNeededImages - 1) {
      RegisterImageResponse res =
          await sendImageToApi(file, faceId, context, isFinal: true);
      if (res.status) {
        if (res.faceFound) {
          if (!res.matching) {
            setMessage("Face not matching, Please try again.");
          } else {
            totalImages++;
            setMessage("Its working... Please stay still.");
            String? appKey = await decrypt(widget.appKey()!, res.faceKey!);
            Global.logger.f("Finaly got app Key : $appKey");
            if (appKey != null) {
              if (Utils.secureSave(key: "app_key", value: appKey)) {
                Global.logger.i("App Key saved successfully");
                await detectionController.dispose();
                showDialog(
                    context: context,
                    builder: (context) => TextPopup(
                          message:
                              "We did it!! We've Successfully Registered your Face",
                          bottomButtons: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Continue"))
                          ],
                        )).then((value) {
                  widget.next();
                });
              } else {
                Global.logger.e("Failed to save app key");
                showDialog(
                    context: context,
                    builder: (context) => TextPopup(
                            message: "Failed to save app key",
                            bottomButtons: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Continue"))
                            ])).then((value) => widget.next());
              }
            }
          }
        } else {
          setMessage("Your face is not clear, Please try again.");
        }
        setState(() {});
      } else {
        setMessage("Oops there is some issues, trying again.");
      }
    }
  }

  Future<RegisterImageResponse> sendImageToApi(
      File imageFile, String faceId, BuildContext context,
      {bool isFinal = false}) async {
    try {
      final url =
          "${apiTypes.SystemConfig.localServer}/api/user/face/register/";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('face', imageFile.path));
      request.fields['face_id'] = faceId;
      request.fields['final'] = isFinal ? "1" : "0";
      var response = await request.send();
      print("FaceID : $faceId");
      String resStr = await response.stream.bytesToString();
      print("Response : $resStr");
      Map<String, dynamic> res = jsonDecode(resStr);

      if (response.statusCode == 200) {
        Global.logger.i("Image successfully sent to the API");
        return RegisterImageResponse.fromJson(true, res['data']);
      } else {
        Global.logger.w(
            "Failed to send image to the API. Status code: ${response.statusCode}");
        return RegisterImageResponse(
            status: false, faceFound: false, matching: false, isFinal: isFinal);
      }
    } catch (e) {
      Global.logger.e("Error sending image to API: $e");
      return RegisterImageResponse(
          status: false, faceFound: false, matching: false, isFinal: isFinal);
    }
  }
}

class RegisterImageResponse {
  final bool status;
  final bool faceFound;
  final bool matching;
  final bool isFinal;
  final String? faceKey;

  RegisterImageResponse(
      {required this.status,
      required this.faceFound,
      required this.matching,
      required this.isFinal,
      this.faceKey});

  factory RegisterImageResponse.fromJson(
      bool status, Map<String, dynamic> json) {
    return RegisterImageResponse(
        status: status,
        faceFound: json['face_found'],
        matching: json['matching'],
        isFinal: json['final'],
        faceKey: json['matching'] && json['final'] ? json['face_key'] : null);
  }
}
