import 'dart:async';

import 'package:convert/convert.dart';
import 'package:vote/services/api/ethers/ethers.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/external_connect/connector.dart';
import 'package:web3dart/web3dart.dart';

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
    Map<String, dynamic>? data = VoterHelper.voterInfo?.toJson() ?? {};
    if (val == null) {
      return const ExternalConnectResponse(false,
          "There was an error with the data from the platform, please try again later!");
    } else {
      Global.logger.i("Handling function type : $val , length : ${val.length}");
      await connector?.sendEncryptedData(data);
      if (val.length == 3) {
        if (val[0] == 'candidate') {
          if (val[1] == 'register') {
            if (val[2] == 'stay') {
              stay = true;
              waiter() async {
                Completer<bool> listener = Completer<bool>();
                connector?.addListener('send_back', (p0) async {
                  Global.logger.i(p0);
                  await EthersCall().requestEthers();
                  String? hash;
                  try {
                    hash = await Contracts.candidate?.registerCandidate(
                        BigInt.from(p0['data']['election']['id'] as int),
                        credentials: VoteChainWallet.credentials!,
                        transaction: Transaction(
                            maxPriorityFeePerGas:
                                EtherAmount.fromInt(EtherUnit.ether, 0)));
                  } catch (err) {
                    connector?.sendResult({'status': 'failed'});
                    listener.complete(false);
                    Global.logger.e("Error registering candidate: $err");
                  }
                  Global.logger.i("Registered with hash : $hash");
                  if (hash != null) {
                    connector?.sendResult({'status': 'success', 'value': hash});
                    listener.complete(true);
                  } else {
                    connector?.sendResult({'status': 'failed'});
                    listener.complete(false);
                  }
                });
                return await listener.future;
              }

              return ExternalConnectResponse(
                  true, "Wait until the operation is complete, please wait!",
                  stayUntilComplete: true, waiter: waiter);
            }
          }
        }
      } else if (val.length == 2) {
        throw UnimplementedError();
        // data[val[0]] = hex.encode(VoteChainWallet.credentials!.privateKey);
        // data[val[1]] = VoteChainWallet.credentials?.address.hex;
      } else if (val.length == 1) {
      } else {
        return const ExternalConnectResponse(false,
            "There was an error with the data from the platform, please try again later! (E0012)");
      }

      return const ExternalConnectResponse(
          true, "Successfully completed operation",
          stayUntilComplete: true);
    }
  }

  Future<ExternalConnectResponse> handleTypeAll() async {
    Map<String, dynamic> _data = VoterHelper.voterInfo!.toJson();
    _data['private_key'] = hex.encode(VoteChainWallet.credentials!.privateKey);
    _data['address'] = VoteChainWallet.credentials?.address.hex;
    bool sts = await connector?.sendEncryptedData(_data) ?? false;

    if (sts) {
      connector?.close();
      return const ExternalConnectResponse(
          true, "Successfully completed operation");
    }
    return const ExternalConnectResponse(false,
        "There was an error connecting with the platform, please try again later!");
  }
}
