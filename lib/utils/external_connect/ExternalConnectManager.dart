import 'dart:async';

import 'package:convert/convert.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/external_connect/connector.dart';
import 'package:vote/utils/external_connect/external_request_proccessor.dart';

class ExternalConnectResponse {
  final bool status;
  final String message;
  final bool stayUntilComplete;
  final Future<bool> Function()? waiter;
  const ExternalConnectResponse(this.status, this.message,
      {this.stayUntilComplete = false, this.waiter});
}

enum ExternalConnectStatus {
  connected("Successfully connected"),
  disconnected("Disconnected From the server"),
  error("There was an error connecting to the server, Please try again later"),
  invalidQrCode(
      "The data in the QR Code is not valid, make sure that you scanned the correct QR");

  final String message;
  const ExternalConnectStatus(this.message);
}

class ExternalConnectManager {
  ExternalConnector? connector;
  bool stay = false;

  Future<ExternalConnectResponse> connectQR(String qrText) async {
    connector = ExternalConnector.fromQRCode(qrText);
    if (connector == null) {
      return const ExternalConnectResponse(false,
          "There was an error connecting with the platform, please try again later!");
    }
    Global.logger.i("Connecting with the client\nRoom: ${connector?.room}\n"
        "Key: ${connector?.key}\nType: ${connector?.type}\nVals: ${connector?.vals}");
    bool res = await connector?.connect() ?? false;
    Global.logger.i("Connection status: $res");
    if (res) {
      switch (connector?.type) {
        case "all":
          return await handleTypeAll();
        case "function":
          return await handleTypeFunction();
      }
      return const ExternalConnectResponse(
          true, "Successfully connected with the client!");
    } else {
      return const ExternalConnectResponse(false,
          "There was an error connecting with the platform, please try again later!");
    }
  }

  Future<ExternalConnectResponse> handleTypeFunction() async {
    List<String>? val = connector?.vals;
    if (val == null) {
      return const ExternalConnectResponse(false,
          "There was an error with the data from the platform, please try again later!");
    } else {
      Global.logger.i("Handling function type : $val , length : ${val.length}");
      ExternalRequestProcessor processor = ExternalRequestProcessor(connector);
      var res = await processor.proccess(val);
      stay = res.stayUntilComplete;
      return res;
    }
  }

  Future<ExternalConnectResponse> handleTypeAll() async {
    Map<String, dynamic> data = VoterHelper.voterInfo!.toJson();
    data['private_key'] = hex.encode(VoteChainWallet.credentials!.privateKey);
    data['address'] = VoteChainWallet.credentials?.address.hex;
    bool sts = await connector?.sendEncryptedData(data) ?? false;

    if (sts) {
      connector?.close();
      return const ExternalConnectResponse(
          true, "Successfully completed operation");
    }
    return const ExternalConnectResponse(false,
        "There was an error connecting with the platform, please try again later!");
  }
}
