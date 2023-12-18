import 'package:vote/services/blockchain/blockChain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../Election.g.dart';
import '../global.dart';
import 'package:flutter/material.dart';
import '../preferences.dart';

// Class that contains nessasary methods to communicate with the blockchain
class ContractLinker extends ChangeNotifier {
  // late String _rpcUrl = "http://127.0.0.1:7545";
  // late String _wsUrl = 'ws://127.0.0.1:7545';
  // late String _privateKey = "null";
  late Election election;
  double _balance = 0;
  late Future<List<Candidates>> candidates;
  late Preferences pref;
  Wallet? wallet;
  /*  
    Function to request Ethers for the registration proccess
    Accepts two optional parametrs onError, onSccess
  */
  Future<Map<String, dynamic>> requestEthers(
      {void Function(String)? onSuccess,
      void Function(String)? onError}) async {
    if (!await BlockchainClient.inited!) return {};
    Map<String, dynamic> ret = {};
    try {
      final res = await post(
          Uri.parse(
              "${Preferences.helperUrl}/api/public/allocateEthersForRegistration"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode({'address': VoteChainWallet.address.toString()}));
      if (res.statusCode != 200) {
        Global.logger.e("Unexpected responce while requesting ethers",
            stackTrace: StackTrace.fromString("Responce : ${res.body}"));
        onError!("Unexpected error occured while registering");
      }
    } catch (err) {
      Global.logger.e(
        "Unexpected error occured while requesting ethers for registration : $err",
      );
      onError!("Unexpected error occured while registering.");
    }
    onSuccess!("Successfully funded account");
    notifyListeners();
    return ret;
  }

  /*
    Function used to register a user into blockchain
    Accepts the name,uid etc
  */
  // Future<bool> register(String name, int uid,
  //     {void Function(String)? onError}) async {
  //   if (!await inited) return false;
  //   if (!await contract_loaded) return false;
  //   try {
  //     await election.registerUser(name,
  //         credentials: _credentials,
  //         transaction: Transaction(
  //             maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));
  //     Global.logger.i("Successfully registered to the blockchain");
  //     return true;
  //   } catch (err) {
  //     Global.logger.e(
  //       "Unexpected error occured while registering the user into blockchain : ${err.toString()}",
  //     );
  //     onError!("Unexpected error occured while creating account");
  //     return false;
  //   }
  // }

  // Future<bool> requestToParticipate(int uid, int electionId) async {
  //   try {
  //     // int from = await client.getBlockNumber();

  //     String hash = await election.requestToParticipate(
  //         BigInt.from(uid), BigInt.from(electionId),
  //         credentials: _credentials,
  //         transaction: Transaction(
  //             maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));

  //     BlockNum block = (await client.getTransactionByHash(hash))!.blockNumber;
  //     election
  //         .userElectionParticipationRequestedEventEvents(
  //             fromBlock: block, toBlock: block)
  //         .listen((event) {
  //       print("UID: ${event.uid}");
  //       print("ElectionId: ${event.electioId}");
  //       print("Request ID: ${event.requestId}");
  //     });
  //     // int to = await client.getBlockNumber();
  //     return true;
  //   } catch (err) {
  //     Global.logger.e("Error requesting to participate in election : $err");
  //     return false;
  //   }
  // }

  // Future<List<Elections>> getElections() async {
  //   await contract_loaded;
  //   List<Elections> elec = [];
  //   try {
  //     for (var i = 1; i <= (await election.electionCount()).toInt(); i++) {
  //       elec.add(await election.elections(BigInt.from(i)));
  //     }
  //   } catch (err) {
  //     Global.logger.e("Error while getting elections : $err");
  //   }
  //   return elec;
  // }

  // /*
  //   Method used to check if a user is verified or not
  // */
  // Future<bool> isVerified() async {
  //   await inited;
  //   await contract_loaded;
  //   try {
  //     return (await election.verified(_address));
  //   } catch (err) {
  //     Global.logger.w(
  //       "An error occured while checking if a user is verified : $err",
  //     );
  //     return false;
  //   }
  // }

  /* Check if the blockchain is alive */
  Future<bool> checkAlive() async {
    if (!await BlockchainClient.inited!) return false;
    try {
      await BlockchainClient.client!.getChainId();
      return true;
    } catch (err) {
      Global.logger.w(
          "Server Not Alive :\n\tAddress : ${Preferences.rpcUrl} Error checking alive status : ${err.toString()}");
      return false;
    }
  }

  // GET BALANCEE
  Future<double> getBalance() async {
    await BlockchainClient.inited!;
    try {
      double bal =
          (await BlockchainClient.client!.getBalance(VoteChainWallet.address!))
              .getValueInUnit(EtherUnit.ether);
      if (_balance != bal) notifyListeners();
      _balance = bal;
      return _balance;
    } catch (err) {
      Global.logger.e("An error occured while checking balance : $err");
      return 0;
    }
  }
}
