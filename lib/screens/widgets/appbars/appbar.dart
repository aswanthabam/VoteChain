// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/qrcode/qr_scanner.dart';
import 'package:vote/utils/external_connect/ExternalConnectManager.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.height = kToolbarHeight});
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 10,
          left: 20,
          right: 20,
          bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'profile');
              },
              icon: const Icon(
                Icons.supervised_user_circle_outlined,
                color: Color(0xFF1BA68D),
              )),
          const Spacer(),
          SizedBox(
            width: 25,
            height: 32,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  child: Image.asset(
                    'src/images/icon.png',
                    width: 25,
                  ))
            ]),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "VoteChain",
            style: TextStyle(
                color: Color(0xFF1BA68D),
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins'),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'admin');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QRScanner(
                      heading: "Scan QR",
                      helpText:
                          "Scan qr code to connect to external application",
                      onResult: (String val) async {
                        ExternalConnectManager manager =
                            ExternalConnectManager();
                        ExternalConnectResponse res =
                            await manager.connectQR(val);
                        if (!res.status) {
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
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                color: Color(0xFF1BA68D),
              )),
        ],
      ),
    );
  }
}
