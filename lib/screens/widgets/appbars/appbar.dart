// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/qrcode/qr_scanner.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/encryption.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
                        print("QR Result: $val");
                        List<String> data = val.split('|');
                        if (data.length != 3) {
                          showDialog(
                              context: context,
                              builder: (context) => TextPopup(
                                    message:
                                        "The data in the QR Code is not valid, make sure that you scanned the correct QR",
                                    bottomButtons: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Continue"))
                                    ],
                                  ));
                        }
                        try {
                          WebSocketChannel channel = WebSocketChannel.connect(
                              Uri.parse(
                                  '${SystemConfig.websocketServer}/ws/user/access/'));
                          Global.logger
                              .i("Sending data to websocket,token: ${data[0]}");

                          channel.sink.add(json
                              .encode({"type": "connect", "token": data[0]}));

                          Completer<bool> listener = Completer<bool>();

                          channel.stream.listen((event) async {
                            Global.logger.w(event);
                            var res = json.decode(event);
                            Global.logger.i(res);

                            if (res['type'] == 'connect_response') {
                              Map<String, dynamic> _data =
                                  VoterHelper.voterInfo!.toJson();
                              _data['private_key'] = hex.encode(
                                  VoteChainWallet.credentials!.privateKey);
                              _data['address'] =
                                  VoteChainWallet.credentials?.address.hex;
                              String encrypted_data =
                                  await encrypt(json.encode(_data), data[1]) ??
                                      '';
                              var _data_send = {
                                "type": "send",
                                "token": data[0],
                                "data": {"value": encrypted_data},
                              };
                              Global.logger
                                  .i("Sending data to websocket : $_data_send");
                              channel.sink.add(json.encode(_data_send));
                            } else if (res['type'] == 'send_response' &&
                                res['status'] == 'success') {
                              channel.sink.close();
                              listener.complete(true);
                              return;
                            } else if (res['type'] == 'send') {
                              return;
                            } else {
                              Global.logger.w(
                                  'WebSocket channel received data, but no use : $event');
                              showDialog(
                                  context: context,
                                  builder: (context) => TextPopup(
                                        message: "Something went wrong!",
                                        bottomButtons: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                listener.complete(false);
                                              },
                                              child: const Text("Continue"))
                                        ],
                                      ));

                              listener.complete(false);
                            }
                          }, onError: (error, stackTrace) {
                            Global.logger.e("Error with websocker :$error");
                            channel.sink.close();
                            listener.completeError(error, stackTrace);
                          }, onDone: () {
                            Global.logger.w('WebSocket channel closed');
                            try {
                              listener.complete(true);
                            } catch (err) {}
                          });
                          await listener.future;
                        } catch (err) {
                          Global.logger.e("Error with websocker :$err");
                          showDialog(
                              context: context,
                              builder: (context) => TextPopup(
                                    message: "Something went wrong!",
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
