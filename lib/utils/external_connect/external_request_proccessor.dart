import 'dart:async';

import 'package:vote/services/api/ethers/ethers.dart';
import 'package:vote/services/api/user.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/external_connect/ExternalConnectManager.dart';
import 'package:vote/utils/external_connect/connector.dart';
import 'package:web3dart/web3dart.dart';

class ExternalRequestProcessor {
  final ExternalConnector? connector;
  ExternalRequestProcessor(this.connector);
  Future<ExternalConnectResponse> proccess(List<String> val) async {
    Global.logger.f("Processing request: $val");
    if (val.length >= 3) {
      if (val[0] == 'candidate') {
        if (val[1] == 'register') {
          if (val[2] == 'stay') {
            Map<String, dynamic>? data = VoterHelper.voterInfo?.toJson() ?? {};
            await connector?.sendEncryptedData(data);
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
                  return;
                }
                Global.logger.i("Registered with hash : $hash");
                if (hash != null) {
                  String? accessKey = await UserAuthCall()
                      .getAccessKey(scope: val[4], clientId: val[3]);
                  if (accessKey == null) {
                    connector?.sendResult({'status': 'failed'});
                    listener.complete(false);
                  } else {
                    connector?.sendResult({
                      'status': 'success',
                      'access_key': accessKey,
                      'name':
                          "${VoterHelper.voterInfo!.personalInfo.firstName} ${VoterHelper.voterInfo!.personalInfo.middleName} ${VoterHelper.voterInfo!.personalInfo.lastName}"
                    });
                    listener.complete(true);
                  }
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
        } else if (val[1] == 'dashboard') {
          if (val[2] == 'stay') {
            String clientId = val[3];
            String scope = val[4];
            Global.logger.i("Candidate Dashboard client id: $clientId");
            String? accessKey = await UserAuthCall()
                .getAccessKey(clientId: clientId, scope: scope);
            Future<bool> waiter() async {
              return await connector!
                  .sendResult({'status': 'success', 'value': accessKey});
            }

            return ExternalConnectResponse(true,
                "Successfully completed operation, please wait for the result!",
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
      return ExternalConnectResponse(false,
          "There was an error with the data from the platform, please try again later! (E0012) (${val.length})");
    }
    return const ExternalConnectResponse(
        true, "Successfully completed operation",
        stayUntilComplete: true);
  }
}
