// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vote/services/global.dart';
import 'package:image/image.dart' as imglib;
import 'dart:math';

class CameraDetectionController {
  bool doneCapturing = false;
  CameraController? controller;
  late Future<CameraController> camera_controller_waiter;
  late List<CameraDescription> _cameras;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  // String? _text;
  int ith_image = 0;
  final _cameraLensDirection = CameraLensDirection.front;
  List<File> capturedImages = [];
  late DateTime _lastCaptureTime;
  final Duration captureGap = const Duration(seconds: 2);
  final Function(List<File>) onDoneCapture;
  final Future<void> Function(File) onImage;
  Function(Function())? setState;
  bool? mounted;
  CameraDetectionController(
      {required this.onDoneCapture, required this.onImage});

  void recapture() {
    doneCapturing = false;
    capturedImages = [];
    controller?.resumePreview();
    controller?.startImageStream(_processCameraImage);
  }

  void startCapturing(Function(Function()) setState, mounted) {
    this.setState = setState;
    this.mounted = mounted;
    _lastCaptureTime = DateTime.now();
    Completer<CameraController> completer = Completer();
    camera_controller_waiter = completer.future;
    availableCameras().then((value) {
      _cameras = value;
      controller = CameraController(_cameras[1], ResolutionPreset.max,
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.nv21
              : ImageFormatGroup.bgra8888,
          enableAudio: false);
      controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        controller?.startImageStream(_processCameraImage);
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              break;
          }
        }
      });
      completer.complete(controller);
    });
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    _processImage(inputImage, image);
  }

  Future<void> _processImage(InputImage inputImage, CameraImage image) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState!(() {
      // _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (faces.length > 1) {
      Global.logger.f("More than one face detected");
    }
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      if (DateTime.now().difference(_lastCaptureTime) >= captureGap &&
          !doneCapturing &&
          faces.isNotEmpty) {
        ith_image++;
        final appDirectory = await getApplicationDocumentsDirectory();
        final String imagePath =
            '${appDirectory.path}/user_captured_image_${ith_image}_${DateTime.now().millisecondsSinceEpoch}.jpg';

        File outFile = await File(imagePath)
            .writeAsBytes((await convertImagetoJpg(inputImage))!);
        // Global.logger.f(
        // "Format : ${image.format.group}, Bytes: ${imageBytes}, Length: ${imageBytes.length}");
        Global.logger.i("Image saved at ${outFile.path}");
        capturedImages.add(outFile);
        await onImage(outFile);
        // _lastCaptureTime = DateTime.now();
        // if (capturedImages.length >= 4) {
        //   doneCapturing = true;
        //   controller!.stopImageStream();
        //   controller!.pausePreview();
        //   Global.logger.f("Done capturing");
        //   onDoneCapture(capturedImages);
        // }
      }
    } else {
      // String text = 'Faces found: ${faces.length}\n\n';
      // for (final face in faces) {
      //   text += 'face: ${face.boundingBox}\n\n';
      // }
      // _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted!) {
      setState!(() {});
    }
  }

  void stopCapturing() {
    doneCapturing = true;
    controller!.stopImageStream();
    controller!.pausePreview();
  }

  Future<Uint8List?> convertImagetoJpg(InputImage image) async {
    try {
      imglib.Image img;
      img = decodeYUV420SP(image);

      imglib.JpegEncoder jpegEncoder = imglib.JpegEncoder(quality: 200);
      Uint8List png = jpegEncoder.encode(img);
      return png;
    } catch (e) {
      Global.logger.e("Error converting image to png: $e");
    }
    return null;
  }

  imglib.Image decodeYUV420SP(InputImage image) {
    final width = image.metadata!.size.width.toInt();
    final height = image.metadata!.size.height.toInt();

    Uint8List yuv420sp = image.bytes!;
    final outImg = imglib.Image(width: width, height: height);

    if (image.metadata!.rotation == InputImageRotation.rotation90deg) {
      outImg.exif.imageIfd.orientation = 6;
    } else if (image.metadata!.rotation == InputImageRotation.rotation180deg) {
      outImg.exif.imageIfd.orientation = 3;
    } else if (image.metadata!.rotation == InputImageRotation.rotation270deg) {
      outImg.exif.imageIfd.orientation = 8;
    } else if (image.metadata!.rotation == InputImageRotation.rotation0deg) {
      outImg.exif.imageIfd.orientation = 1;
    }
    final int frameSize = width * height;

    for (int j = 0, yp = 0; j < height; j++) {
      int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
      for (int i = 0; i < width; i++, yp++) {
        int y = (0xff & yuv420sp[yp]) - 16;
        if (y < 0) y = 0;
        if ((i & 1) == 0) {
          v = (0xff & yuv420sp[uvp++]) - 128;
          u = (0xff & yuv420sp[uvp++]) - 128;
        }
        int y1192 = 1192 * y;
        int r = (y1192 + 1634 * v);
        int g = (y1192 - 833 * v - 400 * u);
        int b = (y1192 + 2066 * u);

        if (r < 0) {
          r = 0;
        } else if (r > 262143) r = 262143;
        if (g < 0) {
          g = 0;
        } else if (g > 262143) g = 262143;
        if (b < 0) {
          b = 0;
        } else if (b > 262143) b = 262143;

        outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
            ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);
      }
    }
    return outImg;
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (controller == null) return null;
    final camera = _cameras[1];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key, required this.controller});
  final CameraDetectionController controller;
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  // CameraController? controller;
  late CameraDetectionController detectionController; // = widget.controller;
  // late Future<CameraController> camera_controller_waiter;
  // late List<CameraDescription> _cameras;
  // bool _canProcess = true;
  // bool _isBusy = false;
  // CustomPaint? _customPaint;
  // String? _text;
  // int ith_image = 0;
  // final _cameraLensDirection = CameraLensDirection.front;
  // List<File> capturedImages = [];
  // late DateTime _lastCaptureTime;
  // final Duration captureGap = const Duration(seconds: 2);
  // bool doneCapturing = false;

  @override
  void didUpdateWidget(covariant CameraApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
    Global.logger.f("Updated widget");
  }

  @override
  void initState() {
    super.initState();
    detectionController = widget.controller;
    detectionController.startCapturing(setState, mounted);
    detectionController.camera_controller_waiter.then((value) {
      setState(() {
        // controller = value;
      });
    });
    setState(() {});
  }

  @override
  void dispose() {
    detectionController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: detectionController.camera_controller_waiter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return const CircularProgressIndicator();
          } else {
            if (!detectionController.controller!.value.isInitialized) {
              return Container();
            }
            return ClipOval(
                child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width:
                    detectionController.controller!.value.previewSize!.height +
                        300,
                height:
                    detectionController.controller!.value.previewSize!.width,
                child: CameraPreview(
                  detectionController.controller!,
                  child: detectionController._customPaint,
                ),
              ),
            ));
          }
        });
  }
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = const Color.fromARGB(255, 106, 177, 235);
    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0
      ..color = const Color.fromARGB(255, 122, 217, 125);

    for (final Face face in faces) {
      void paintContour(FaceContourType type) {
        final contour = face.contours[type];
        if (contour?.points != null) {
          for (final Point point in contour!.points) {
            canvas.drawCircle(
                Offset(
                  translateX(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    point.y.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                ),
                1,
                paint1);
          }
        }
      }

      void paintLandmark(FaceLandmarkType type) {
        final landmark = face.landmarks[type];
        if (landmark?.position != null) {
          canvas.drawCircle(
              Offset(
                translateX(
                  landmark!.position.x.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  landmark.position.y.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              5,
              paint2);
        }
      }

      for (final type in FaceContourType.values) {
        paintContour(type);
      }

      for (final type in FaceLandmarkType.values) {
        paintLandmark(type);
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}

double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}
