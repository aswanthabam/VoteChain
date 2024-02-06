import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/progress_bar/radial_progress.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart' as apiTypes;
import '../../../widgets/paginated_views/paginated_views.dart' as paging;
import 'package:http/http.dart' as http;

class FaceRegisterPage extends FormPage<String> {
  @override
  // ignore: overridden_fields
  String? validatedData;
  Function()? hideContinueButton;
  final String? Function() faceId;
  final Function() next;
  FaceRegisterPage(
      {this.hideContinueButton, required this.faceId, required this.next});

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
    return FaceRegisterWidget(pageState: this, faceId: faceId, next: next);
  }
}

class FaceRegisterWidget extends StatefulWidget {
  const FaceRegisterWidget(
      {super.key,
      required this.pageState,
      required this.faceId,
      required this.next});

  final paging.PageState pageState;
  final Function() next;
  final String? Function() faceId;
  @override
  State<FaceRegisterWidget> createState() => _FaceRegisterWidgetState();
}

class _FaceRegisterWidgetState extends State<FaceRegisterWidget> {
  late CameraDetectionController detectionController;
  int totalImages = 0;
  int totalNeededImages = 10;

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
    detectionController = CameraDetectionController(onImage: onImage);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UnderlinedText(
                  heading: "Register Your face",
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
        ));
  }

  void startRecapture() {}

  Future<void> onImage(File file) async {
    String? faceId = widget.faceId();
    if (faceId == null) {
      Global.logger.e("FaceID is null");
      return;
    }
    if (totalImages < totalNeededImages - 1) {
      bool res = await sendImageToApi(file, faceId, context, isFinal: false);
      if (res) {
        totalImages++;
        setState(() {});
      }
    } else if (totalImages == totalNeededImages - 1) {
      bool res = await sendImageToApi(file, faceId, context, isFinal: true);
      if (res) {
        totalImages++;
        setState(() {});
      }
    } else {
      detectionController.stopCapturing();
      detectionController.controller?.dispose();
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                message: "We did it!! We've Successfully Registered your Face",
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
    }
  }

  Future<bool> sendImageToApi(
      File imageFile, String faceId, BuildContext context,
      {bool isFinal = false}) async {
    try {
      final url =
          "${apiTypes.SystemConfig.localServer}/api/user/face/register/";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('face', imageFile.path));
      // ignore: use_build_context_synchronously
      request.fields['face_id'] = faceId;
      request.fields['final'] = isFinal ? "1" : "0";
      var response = await request.send();
      print("FaceID : $faceId");
      print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        Global.logger.i("Image successfully sent to the API");
        return true;
      } else {
        Global.logger.w(
            "Failed to send image to the API. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      Global.logger.e("Error sending image to API: $e");
      return false;
    }
  }
}

void _showImageSelectionPopup(BuildContext context, List<File> imageUrls,
    Function(File) onImageSelected, Function() recapture) {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Which of the following shows your face clearly?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Click on the image on which your face is clear.",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          File selected = imageUrls[index];
                          showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => Dialog(
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Does this image shows your beautiful face ?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(selected),
                                          ),
                                          getPrimaryAsyncButton(context,
                                              () async {
                                            onImageSelected(selected);
                                            return true;
                                          },
                                              "Confirm",
                                              "Loading",
                                              "An Error Occured",
                                              "Success",
                                              MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20)
                                        ],
                                      )))).then((_) {
                            // recapture();
                          });
                        },
                        child: Image.file(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ));
    },
  ).then((value) {
    recapture();
  });
}
