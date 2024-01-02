import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/services/global.dart';

class QRScanner extends StatefulWidget {
  final String heading;
  final String helpText;
  final bool exitOnResult;
  final Future<void> Function(String) onResult;
  const QRScanner(
      {super.key,
      required this.heading,
      required this.onResult,
      this.helpText = "Scan the QR Code continue",
      this.exitOnResult = true});

  @override
  QRScannerState createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool exited = false;
  bool result_proccessing = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackBar(onPressed: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: 10,
            left: 10,
            right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Icon(
              Icons.qr_code_2,
              size: 50,
              color: Colors.grey.shade800,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.heading,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.helpText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            // Spacer(),
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      await controller.toggleFlash();
                    },
                    icon: const Icon(Icons.lightbulb_outline_rounded)),
                IconButton(
                    onPressed: () async {
                      await controller.flipCamera();
                    },
                    icon: const Icon(Icons.cameraswitch_outlined)),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (scanData.code != null) {
        if (scanData.format != BarcodeFormat.qrcode) {
          Global.logger
              .w("NOT A QR CODE : ${scanData.format} && ${scanData.code}");
          controller.resumeCamera();
          return;
        }
        if (result_proccessing) {
          Global.logger.w("Result already being processed");
          return;
        }
        result_proccessing = true;
        await widget.onResult(scanData.code!);
        result_proccessing = false;
        if (widget.exitOnResult && !exited) {
          exited = true;
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      }
    });
  }
}
