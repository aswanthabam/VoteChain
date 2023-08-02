import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../Election.g.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:provider/provider.dart';
import 'preferences.dart';
import '../components/dialog.dart';
import 'utils.dart';

class ContractLinker extends ChangeNotifier {
  late String _rpcUrl = "http://192.168.18.2:7545";
  late String _wsUrl = 'ws://192.168.18.2:7545';
  late String _privateKey = "null";

  late Web3Client client;
  var httpClient = Client();
  late EthPrivateKey _credentials;
  late EthereumAddress _privatekey;
  late EthereumAddress _address;
  late EthereumAddress _contractAddress;
  late Election election;
  late Future<bool> contract_loaded;
  double _balance = 0;
  late Future<List<Candidates>> candidates;
  late Preferences pref;
  late Future<void> inited;
  Wallet? wallet;
  // BuildContext context;
  // Functions
  // ContractLinker({BuildContext context});
  void init({cond}) {
    inited = init2(cond: cond);
  }

  void loadContracts() {
    contract_loaded = loadContracts2();
  }

  Future<void> init2({cond}) async {
    if (cond != null) {
      cond = cond as Future<void>;
      await cond;
      initWeb3();
      // createAccount();
      // contract_loaded = loadContracts();
    } else {
      initWeb3();
      // createAccount();
      // contract_loaded = loadContracts();
    }
  }

  Future<bool> initWeb3() async {
    print("Initializing  ...");
    try {
      client = Web3Client(Preferences.rpcUrl, httpClient, socketConnector: () {
        return IOWebSocketChannel.connect(Preferences.wsUrl).cast<String>();
      });
      client.getChainId().then((value) {
        print("Chain Id: $value");
      });
      return true;
    } catch (err) {
      print(err);
      print("Error initializing web3 client");
      return false;
    }
  }

  Future<void> createAccount() async {
    print("Creating account ...");
    var ran = Random.secure();
    _credentials = EthPrivateKey.createRandom(ran);
    print(_credentials.toString());
    _address = _credentials.address;
    print("Created : " + _address.hex);
    getBalance();
    notifyListeners();
  }

  bool saveWallet(String name, int uid, String password) {
    try {
      wallet = Wallet.createNew(_credentials, password, Random.secure());
      if (Utils.secureSave(
          key: "account", value: wallet!.toJson().toString())) {
        print("saved");
        return true;
      } else {
        print("Cant save");
        return false;
      }
    } catch (err) {
      print("Error: " + err.toString());
      return false;
    }
  }

  Future<bool> loadWallet(String password) async {
    try {
      print("Loading account ...");
      String encoded = (await Utils.storage.read(key: "account"))!;
      print(encoded);
      wallet = Wallet.fromJson(encoded, password);
      _credentials = wallet!.privateKey;
      _address = _credentials.address;
      print("Loaded account");
      return true;
    } catch (err) {
      print("Error: " + err.toString());
      return false;
    }
  }

  Future<bool> loadContracts2() async {
    await inited;
    print("Loading Contracts ...");
    try {
      String abiString =
          await rootBundle.loadString("src/artifacts/Election.json");
      var jsonAbi = jsonDecode(abiString);
      _contractAddress = EthereumAddress.fromHex(Preferences.contractAddress ??
          jsonAbi['networks']['5777']['address']);
      print("Contract Address : $_contractAddress");
      election =
          Election(address: _contractAddress, client: client, chainId: 1337);
      print("Loaded Contracts");
      return true;
    } catch (err) {
      print("Error loading contracts: " + err.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> requestEthers(context) async {
    await inited;
    Map<String, dynamic> ret = {};
    print("Requesting ethers for : " + _address.toString());
    try {
      final res = await post(
          Uri.parse(Preferences.helperUrl +
              "/api/public/allocateEthersForRegistration"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode({'address': _address.toString()}));
      if (res.statusCode != 200) {
        print("Request for ethers failed");
        showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Center(child: Text("Voting Failed"))]))));
      }
    } catch (err) {
      print("Unable to fund account");
      showDialog(
          context: context,
          builder: (builder) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              child: const Padding(
                  padding: EdgeInsets.all(16),
                  // height: 100,
                  // decoration: BoxDecoration(color: Colors.white),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Center(child: Text("Error getting ethers"))
                  ]))));
    }
    print("Account balance : " + (await getBalance()).toString() + " ETH");
    notifyListeners();
    return ret;
  }

  Future<bool> register(String name, int uid, BuildContext context) async {
    await inited;
    await contract_loaded;
    // createAccount();
    // requestEthers(context);
    try {
      var res = await election.registerUser(BigInt.from(uid), name,
          credentials: _credentials,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));
      // var subscription = election
      //     .userRegisteredEventEvents(
      //         fromBlock: BlockNum.genesis(), toBlock: BlockNum.current())
      //     .take(1)
      //     .listen((event) {
      //   // UserRegisteredEvent
      // });
      print("Transaction : " + res);
      return true;
    } catch (err) {
      print(err);
      showDialog(
          context: context,
          builder: ((context) => MsgDialog(
              icon: Icons.error_outline,
              iconColor: Colors.red,
              iconSize: 30,
              text: "An Unexpected error occured while creating account")));
      return false;
    }
  }

  Future<bool> isVerified() async {
    await inited;
    await contract_loaded;
    // try {
    // election.self.function('verified');
    print(await client.call(
        contract: election.self,
        function: election.self.function('verified'),
        params: [_address]));
    return true;
    // return (await election.verified(_address));
    // } catch (err) {
    // throw err;
    // return false;
    // }
  }

  // GET BALANCEE
  Future<double> getBalance() async {
    await inited;
    try {
      double bal =
          (await client.getBalance(_address)).getValueInUnit(EtherUnit.ether);
      if (_balance != bal) notifyListeners();
      _balance = bal;
      return _balance;
    } catch (err) {
      return 0;
    }
  }

  Future<EthereumAddress> getAddress() async {
    await inited;
    return _address;
  }

  Future<EthPrivateKey> getCredentials() async {
    await inited;
    return _credentials;
  }
}
