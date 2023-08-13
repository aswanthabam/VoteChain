import 'package:web3dart/web3dart.dart';
import 'dart:math';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../Election.g.dart';
import 'preferences.dart';
import 'global.dart';
import 'utils.dart';
import 'package:flutter/material.dart';

class ContractLinker extends ChangeNotifier {
  late Web3Client client;
  var httpClient = Client();
  late EthPrivateKey _admin_credentials;
  late EthereumAddress _admin_address;
  late EthereumAddress _contractAddress;
  late Election election;
  late Future<bool> contract_loaded;
  double _balance = 0;
  late Future<List<Candidates>> candidates;
  late Preferences pref;
  late Future<bool> inited;
  Wallet? wallet;
  /* 
    Function that overlaps the init function to make it async and for storing it in inited Future variable
  */
  void init() {
    inited = initWeb3();
  }

  /*
    Function that overlaps the loadContracts function for storing the Future state in contract_loaded
  */
  void loadContracts() {
    contract_loaded = loadContracts2();
  }

  /*
    Function to initialize the Web3 Client
  */
  Future<bool> initWeb3() async {
    Global.logger.i("Initializing Web3 Client");
    try {
      client = Web3Client(Preferences.rpcUrl, httpClient, socketConnector: () {
        return IOWebSocketChannel.connect(Preferences.wsUrl).cast<String>();
      });
      return true;
    } catch (err) {
      Global.logger.e(
        "An unexpected error occured while initalizing Web3 Client : $err",
      );
      return false;
    }
  }

  /*
    Function to save the created wallet into the permenent storage
    Accepts the name,uid and password to encrypt the wallet
  */
  // bool saveWallet(String name, int uid, String password) {
  //   try {
  //     wallet = Wallet.createNew(_admin_credentials, password, Random.secure());
  //     if (Utils.secureSave(
  //         key: "account",
  //         value: json.encode(
  //             {"wallet": wallet!.toJson(), "name": name, "uid": uid}))) {
  //       Global.userName = name;
  //       Global.userId = uid;
  //       Global.logger.i("Saved the wallet");
  //       return true;
  //     } else {
  //       Global.logger.w("The wallet was not saved properly");
  //       return false;
  //     }
  //   } catch (err) {
  //     Global.logger.e(
  //       "An Unexpected error occured while saving the wallet : $err",
  //     );
  //     return false;
  //   }
  // }

  /*
    Function to load the saved wallet  credentials
    Accepts the password to decrypt the encrypted wallet
  */
  // Future<bool> loadWallet(String password) async {
  //   try {
  //     Map<String, dynamic> encoded =
  //         json.decode((await Utils.storage.read(key: "account"))!);
  //     Global.userId = encoded["uid"];
  //     Global.userName = encoded["name"];
  //     wallet = Wallet.fromJson(encoded["wallet"].toString(), password);
  //     _admin_credentials = wallet!.privateKey;
  //     _admin_address = _admin_credentials.address;
  //     Global.logger.i("Loaded wallet from saved");
  //     return true;
  //   } catch (err) {
  //     Global.logger.e(
  //       "An unexpected error occured while loading the wallet : $err",
  //     );
  //     return false;
  //   }
  // }

  /*
    Load Wallet from given private Key
  */
  Future<bool> loadWalletFromKey(String password) async {
    try {
      Map<String, dynamic> data = {
        "version": 3,
        "id": '694fa045-a898-436a-9cae-f001836e564b',
        "address": '90f8bf6a479f320ead074411a4b0e7944ea8c9c1',
        "crypto": {
          "ciphertext":
              '106c2ea2c84674eaa0a5056f7973dcf1bd750a2ce28d3b3343d79d4f1bf635a2',
          "cipherparams": {"iv": '8c65e4e15aaa7c61645d4a96d76b686f'},
          "cipher": 'aes-128-ctr',
          "kdf": 'scrypt',
          "kdfparams": {
            "n": 8192,
            "r": 8,
            "p": 1,
            "dklen": 32,
            "salt":
                '530ff0828b6e3a4a82b322421d2e6289bb22e3f718776cdbab14c9893b43dfed'
          },
          "mac":
              'cfcc65e6ddddf32c6710ec5c2da03f8553c13e01b399b0cae2fd8f9d95c201bf'
        }
      };
      wallet = Wallet.fromJson(json.encode(data).toString(), password);
      _admin_credentials = wallet!.privateKey;
      _admin_address = _admin_credentials.address;
      Global.logger.i("Loaded wallet from address : ${_admin_address.hex}");
      return true;
    } catch (err) {
      Global.logger.e(
        "An unexpected error occured while loading the wallet : $err",
      );
      return false;
    }
  }

  // Future<bool> logOut() async {
  //   try {
  //     await Utils.storage.deleteAll();
  //     Global.userId = null;
  //     Global.userName = null;
  //     return true;
  //   } catch (err) {
  //     Global.logger.e("An unexpected error occured while logging out : $err");
  //     return false;
  //   }
  // }

  /*
    Load the contracts, which can be used to intract with the contract
  */
  Future<bool> loadContracts2() async {
    if (!await inited) return false;
    try {
      String abiString =
          await rootBundle.loadString("src/artifacts/Election.json");
      var jsonAbi = jsonDecode(abiString);
      _contractAddress = EthereumAddress.fromHex(Preferences.contractAddress ??
          jsonAbi['networks']['5777']['address']);
      election =
          Election(address: _contractAddress, client: client, chainId: 1337);
      Global.logger.i("Loaded contract : ${_contractAddress.hex}");
      return true;
    } catch (err) {
      Global.logger.e(
        "An error occured while trying to load the contract : $err",
      );
      return false;
    }
  }

  /*
    Method used to check if a user is verified or not 
  */
  Future<bool> isVerified(EthereumAddress address) async {
    await inited;
    await contract_loaded;
    try {
      return (await election.verified(address));
    } catch (err) {
      Global.logger.w(
        "An error occured while checking if a user is verified : $err",
      );
      return false;
    }
  }

  /* Check if the blockchain is alive */
  Future<bool> checkAlive() async {
    if (!await inited) return false;
    try {
      await client.getChainId();
      return true;
    } catch (err) {
      Global.logger.w(
          "Server Not Alive :\n\tAddress : ${Preferences.rpcUrl} Error checking alive status : ${err.toString()}");
      return false;
    }
  }

  Future<List<Elections>> getElections({Function? onError}) async {
    List<Elections> elecs = [];
    try {
      var elecCount = await election.electionCount();
      for (var i = 1; i <= elecCount.toInt(); i++) {
        elecs.add(await election.elections(elecCount));
      }
    } catch (err) {
      onError!();
      Global.logger
          .e("An Error occured while fetching elections : ${err.toString()}");
    }
    return elecs;
  }

  Future<bool> addElection(String name, {Function? onError}) async {
    try {
      await election.addElectionEntity(name,
          credentials: _admin_credentials,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));
      Global.logger.i("Added new election");
      return true;
    } catch (err) {
      onError!();
      Global.logger.e("Error occured while adding election : $err");
      return false;
    }
  }

  // GET BALANCEE
  Future<double> getBalance(EthereumAddress address) async {
    await inited;
    try {
      double bal =
          (await client.getBalance(address)).getValueInUnit(EtherUnit.ether);
      if (_balance != bal) notifyListeners();
      _balance = bal;
      return _balance;
    } catch (err) {
      Global.logger.e("An error occured while checking balance : $err");
      return 0;
    }
  }

  // get the current address of the user
  Future<EthereumAddress> getAddress() async {
    await inited;
    return _admin_address;
  }

  // get the credentials : private key
  Future<EthPrivateKey> getCredentials() async {
    await inited;
    return _admin_credentials;
  }
}
