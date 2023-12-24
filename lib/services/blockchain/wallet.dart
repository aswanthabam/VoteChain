import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/global.dart';
import 'package:vote/services/utils.dart';
import 'package:web3dart/web3dart.dart';
import 'package:wallet/wallet.dart' as web3_wallet;

enum VoteChainWalletStatus {
  createdNew("Created a new account!"),
  loadedSaved("Loaded Account from wallet"),
  wrongPassword("You have entered a wrong password"),
  errorOccured("An error occured while loading the wallet");

  final String description;

  const VoteChainWalletStatus(this.description);
}

class VoteChainWallet {
  static EthPrivateKey? credentials;
  static EthereumAddress? address;
  static Wallet? wallet;
  static Future<VoteChainWalletStatus>? inited;
  static List<String>? mnemonic;
  static void init(String? password) {
    inited = init2(password: password);
  }

  static Future<VoteChainWalletStatus> init2({String? password}) async {
    try {
      if (password == null) {
        await createAccount();
        Global.logger.i("Created a new account ");
        return VoteChainWalletStatus.createdNew;
      } else {
        if (!await loadWallet(password)) {
          Global.logger.i("Loading account from saved");
          return VoteChainWalletStatus.loadedSaved;
        }
        Global.logger.i("Wrong password!");
        return VoteChainWalletStatus.wrongPassword;
      }
    } catch (err) {
      return VoteChainWalletStatus.errorOccured;
    }
  }

  /*
    Function to generate a public and private key pairs
  */
  static Future<void> createAccount() async {
    mnemonic = web3_wallet.generateMnemonic();
    Uint8List seed =
        web3_wallet.mnemonicToSeed(mnemonic!, passphrase: 'myhome');
    var master = web3_wallet.ExtendedPrivateKey.master(seed, web3_wallet.xprv);
    var root = master.forPath("m/44'/195'/0'/0/0");
    var privateKey =
        web3_wallet.PrivateKey((root as web3_wallet.ExtendedPrivateKey).key);
    credentials = EthPrivateKey.fromInt(privateKey.value);
    address = credentials!.address;
    Global.logger.i("Created address : ${address!.hex}");
    Global.logger.i("Mneumonic : ${mnemonic!.join(' ')}");
  }

  /*
    Function to save the created wallet into the permenent storage
    Accepts the name,uid and password to encrypt the wallet
  */
  static bool saveWallet(String password) {
    try {
      wallet = Wallet.createNew(credentials!, password, Random.secure());
      if (Utils.secureSave(
          key: "account", value: json.encode({"wallet": wallet!.toJson()}))) {
        Global.logger.i("Saved the wallet");
        return true;
      } else {
        Global.logger.w("The wallet was not saved properly");
        return false;
      }
    } catch (err) {
      Global.logger.e(
        "An Unexpected error occured while saving the wallet : $err",
      );
      return false;
    }
  }

  /*
    Function to load the saved wallet  credentials
    Accepts the password to decrypt the encrypted wallet
  */
  static Future<bool> loadWallet(String password) async {
    try {
      Map<String, dynamic> encoded =
          json.decode((await Utils.storage.read(key: "account"))!);
      // Global.userId = encoded["uid"];
      // Global.userName = encoded["name"];
      wallet = Wallet.fromJson(encoded["wallet"].toString(), password);
      credentials = wallet!.privateKey;
      address = credentials!.address;
      Global.logger.i("Loaded wallet from saved");
      return true;
    } catch (err) {
      Global.logger.e(
        "An unexpected error occured while loading the wallet : $err",
      );
      return false;
    }
  }

  static Future<bool> logOut() async {
    try {
      await Utils.storage.deleteAll();
      Global.userId = null;
      Global.userName = null;
      return true;
    } catch (err) {
      Global.logger.e("An unexpected error occured while logging out : $err");
      return false;
    }
  }

  static Future<bool> hasSavedWallet() async {
    try {
      Map<String, dynamic> encoded =
          json.decode((await Utils.storage.read(key: "account"))!);
      if (encoded['wallet'] != null) return true;
      return false;
    } catch (err) {
      Global.logger.e(
        "An unexpected error occured while loading the wallet : $err",
      );
      return false;
    }
  }

  // get the current address of the user
  Future<EthereumAddress> getAddress() async {
    await BlockchainClient.inited;
    return VoteChainWallet.address!;
  }

  // get the credentials : private key
  Future<EthPrivateKey> getCredentials() async {
    await BlockchainClient.inited;
    return VoteChainWallet.credentials!;
  }
}
