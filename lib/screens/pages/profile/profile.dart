import 'package:flutter/material.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/pages/face_verification/face_verification.dart';
import 'package:vote/screens/pages/register/final/detector_view.dart';
import 'package:vote/screens/widgets/buttons/fullsize_action_button/full_size_action_button.dart';
import 'package:vote/screens/widgets/content_views/card/card.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/qrcode/qr_scanner.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/external_connect/ExternalConnectManager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayer(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(children: [
            const CardWidget(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FullSizeActionButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  icon2: const Icon(Icons.keyboard_arrow_right_rounded),
                  text: "Scan QR Code",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QRScanner(
                          heading: "Scan QR",
                          helpText:
                              "Scan qr code to connect to external application",
                          onResult: (String val) async {
                            ExternalConnectManager manager =
                                ExternalConnectManager();
                            ExternalConnectResponse res =
                                await manager.connectQR(val);
                            if (res.stayUntilComplete) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TextPopup(
                                      message: res.message,
                                      bottomButtons: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Continue"))
                                      ],
                                    );
                                  });
                              await res.waiter!();
                            }
                            if (!res.status) {
                              // ignore: use_build_context_synchronously
                              await showDialog(
                                  context: context,
                                  builder: (context) => TextPopup(
                                        message: res.message,
                                        bottomButtons: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Continue"))
                                        ],
                                      ));
                            }
                          });
                    }));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: FullSizeActionButton(
                icon: const Icon(Icons.face_retouching_natural_sharp),
                icon2: const Icon(Icons.chevron_right_outlined),
                text: "Test Face Verification",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FaceVerificationPage(
                                onVerificationComplete: (bool sts,
                                    String? faceKey,
                                    CameraDetectionController
                                        detectionController) {
                                  if (sts) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => TextPopup(
                                              message:
                                                  "Gotchu!! Successfully verified you, you are the we are looking for!",
                                              bottomButtons: [
                                                TextButton(
                                                    onPressed: () {
                                                      detectionController
                                                          .controller
                                                          ?.dispose();
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        "Continue, and go back"))
                                              ],
                                            ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => TextPopup(
                                              message:
                                                  "Oops! Seems like you are not the one we are looking for!",
                                              bottomButtons: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      detectionController
                                                          .recapture();
                                                    },
                                                    child: const Text(
                                                        "Try Again")),
                                                TextButton(
                                                    onPressed: () {
                                                      detectionController
                                                          .controller
                                                          ?.dispose();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Back"))
                                              ],
                                            )).then((value) {
                                      detectionController.controller?.dispose();
                                      try {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      } catch (e) {}
                                    });
                                  }
                                },
                              )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: FullSizeActionButton(
                icon: const Icon(Icons.logout),
                icon2: const Icon(Icons.chevron_right_outlined),
                text: "Logout",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => TextPopup(
                            message:
                                "Are You sure you want to logout? You want to login with your credentials again to relogin.",
                            bottomButtons: [
                              TextButton(
                                  onPressed: () async {
                                    await VoteChainWallet.logOut();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, 'splashscreen');
                                  },
                                  child: const Text(
                                    "Yes, Logout",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No, Exit"))
                            ],
                          ));
                },
              ),
            ),
          ]))),
    );
  }
}
