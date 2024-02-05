import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
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

  @override
  FormPageStatus validate() {
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return FaceRegisterWidget(pageState: this);
  }
}

class FaceRegisterWidget extends StatefulWidget {
  const FaceRegisterWidget({super.key, required this.pageState});

  final paging.PageState pageState;
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
    detectionController = CameraDetectionController(
        onDoneCapture: (var files) {
          _showImageSelectionPopup(context, files, (File file) {
            sendImageToApi(file, context, isFinal: true);
          }, detectionController.recapture);
        },
        onImage: onImage);
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
              // LinearProgressIndicator(
              //   value: totalImages / totalNeededImages,
              // ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                // fit: StackFit.expand,
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
    if (totalImages < totalNeededImages - 1) {
      bool res = await sendImageToApi(file, context, isFinal: false);
      if (res) {
        totalImages++;
        setState(() {});
      }
    } else if (totalImages == totalNeededImages - 1) {
      bool res = await sendImageToApi(file, context, isFinal: true);
      if (res) {
        totalImages++;
        setState(() {});
      }
    } else {
      detectionController.stopCapturing();
    }
  }

  Future<bool> sendImageToApi(File imageFile, BuildContext context,
      {bool isFinal = false}) async {
    try {
      final url =
          "${apiTypes.SystemConfig.localServer}/api/user/face/register/";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('face', imageFile.path));
      // ignore: use_build_context_synchronously
      request.fields['face_id'] = '3e7e882e-6f8a-4b3b-a6b7-25c3abe3776c';
      request.fields['final'] = isFinal ? "1" : "0";
      var response = await request.send();
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
