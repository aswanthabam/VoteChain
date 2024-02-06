// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vote/services/global.dart';
import 'package:image/image.dart' as imglib;
import 'dart:math';

class CameraDetectionController {
  late Future<CameraController> cameraControllerWaiter;
  late List<CameraDescription> _cameras;
  bool doneCapturing = false;
  CameraController? controller;
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
  final bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  int ithImage = 0;
  final _cameraLensDirection = CameraLensDirection.front;
  List<File> capturedImages = [];
  final Duration captureGap = const Duration(seconds: 1);
  bool? mounted;
  bool _isPostProcessing = false;
  bool _isDisposed = false;

  final Future<void> Function(File) onImage;
  Function(Function())? setState;

  // late DateTime _lastCaptureTime;

  CameraDetectionController({required this.onImage});
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _faceDetector.close();
    controller?.dispose();
  }

  void recapture() {
    if (_isDisposed) return;
    doneCapturing = false;
    capturedImages = [];
    controller?.resumePreview();
    controller?.startImageStream(_processCameraImage);
  }

  void startCapturing(Function(Function()) setState, mounted) {
    if (_isDisposed) return;
    this.setState = setState;
    this.mounted = mounted;
    // _lastCaptureTime = DateTime.now();
    Completer<CameraController> completer = Completer();
    cameraControllerWaiter = completer.future;
    availableCameras().then((value) {
      _cameras = value;
      controller = CameraController(_cameras[1], ResolutionPreset.ultraHigh,
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
    // if (DateTime.now().difference(_lastCaptureTime) >= captureGap) {
    _processImage(inputImage, image);
    // }
  }

  static Future<File> saveImage(Uint8List imageBytes) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final String imagePath =
        '${appDirectory.path}/face_images/user_captured_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    File outFile = File(imagePath);
    await outFile.create(recursive: true);
    await outFile.writeAsBytes(imageBytes);
    return outFile;
  }

  void processImageAndSend(CameraImage image) {
    final stopwatch = Stopwatch()..start();

    convertImagetoJpg(image).then((jpgImage) {
      if (jpgImage != null) {
        final convertTime = stopwatch.elapsedMilliseconds;
        Global.logger.f("Image conversion time: $convertTime ms");

        saveImage(jpgImage).then((value) {
          final saveTime = stopwatch.elapsedMilliseconds - convertTime;
          Global.logger.f("Image save time: $saveTime ms");

          ithImage++;
          capturedImages.add(value);

          onImage(value).then((onImageTime) {
            final totalTime = stopwatch.elapsedMilliseconds;
            Global.logger.f("Total processing time: $totalTime ms");
            _isPostProcessing = false;
          }).catchError((e) {
            Global.logger.e("Error running onImage image: $e");
            _isPostProcessing = false;
          });
        }).catchError((e) {
          Global.logger.e("Error saving image: $e");
          _isPostProcessing = false;
        });
      }
    }).catchError((e) {
      Global.logger.e("Error converting image to jpg: $e");
      _isPostProcessing = false;
    });
  }

  Future<void> _processImage(InputImage inputImage, CameraImage image) async {
    if (_isDisposed) return;
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
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
      if (
          // DateTime.now().difference(_lastCaptureTime) >= captureGap &&
          //   !doneCapturing &&
          faces.isNotEmpty) {
        if (!_isPostProcessing) {
          _isPostProcessing = true;
          processImageAndSend(image);
        }
      }
    } else {
      _customPaint = null;
    }
    if (mounted!) {
      setState!(() {});
    }
    _isBusy = false;
  }

  void stopCapturing() {
    if (_isDisposed) return;
    doneCapturing = true;
    controller!.stopImageStream();
    controller!.pausePreview();
  }

  Future<Uint8List> postProccessImageThread(imglib.Image inp) async {
    Global.logger.f("Post processing image");
    return await compute(postProcessImage, inp);
  }

  static Uint8List postProcessImage(imglib.Image img) {
    Global.logger.f("Post processing image 2");
    img = imglib.copyRotate(img, angle: 270);
    img = imglib.copyResize(img, width: img.width * 2, height: img.height * 2);
    return imglib.encodeJpg(img);
  }

  Future<Uint8List?> convertImagetoJpg(CameraImage image) async {
    try {
      imglib.Image img;
      final stopwatch = Stopwatch()..start();
      img = await decodeYUV420SPThread(image);
      final decodeTime = stopwatch.elapsedMilliseconds;
      Global.logger.f("Image Width: ${img.width}, Height: ${img.height}");
      final imgBytes = await postProccessImageThread(img);
      final saveTime = stopwatch.elapsedMilliseconds - decodeTime;
      stopwatch.stop();
      Global.logger
          .f("Decode time: $decodeTime ms and post Process time: $saveTime ms");
      Uint8List png =
          Uint8List.fromList(imgBytes); // await postProccessImage(img);
      return png;
    } catch (e) {
      Global.logger.e("Error converting image to png: $e");
    }
    return null;
  }

  Future<imglib.Image> decodeYUV420SPThread(CameraImage image) async {
    return await compute(decodeYUV420SP, image);
  }

  static imglib.Image decodeYUV420SP(CameraImage image) {
    final width = image.width;
    final height = image.height;

    Uint8List yuv420sp = image.planes.first.bytes;
    final outImg = imglib.Image(width: width, height: height);

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
  // late Future<CameraController> cameraControllerWaiter;
  // late List<CameraDescription> _cameras;
  // bool _canProcess = true;
  // bool _isBusy = false;
  // CustomPaint? _customPaint;
  // String? _text;
  // int ithImage = 0;
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
    detectionController.cameraControllerWaiter.then((value) {
      setState(() {
        // controller = value;
      });
    });
    setState(() {});
  }

  @override
  void dispose() {
    detectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: detectionController.cameraControllerWaiter,
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
