import 'package:web3dart/web3dart.dart';
import 'dart:math';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'Election.g.dart';

class ContractLinker {
  final String _rpcUrl = "http://192.168.18.2:7545";
  final String _wsUrl = 'ws://192.168.18.2:7545';
  final String _privateKey = "null";

  late Web3Client client;
  var httpClient = Client();
  late Credentials credentials;
  late EthereumAddress privatekey;
  late EthereumAddress address;
  late EthereumAddress _contractAddress;
  late Election election;
  late Future<bool> contract_loaded;
  // Functions
  ContractLinker() {
    initWeb3();
    contract_loaded = loadContracts();
  }

  void initWeb3() {
    print("Initializing  ...");
    client = Web3Client(_rpcUrl, httpClient, socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    print("Creating account ...");
    var ran = Random.secure();
    credentials = EthPrivateKey.createRandom(ran);
    address = credentials.address;
    print("Created : " + address.hex);
  }

  Future<bool> loadContracts() async {
    print("Loading Contracts ...");
    String abiString =
        await rootBundle.loadString("src/artifacts/Election.json");
    var jsonAbi = jsonDecode(abiString);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
    election =
        Election(address: _contractAddress, client: client, chainId: 5777);
    print("Loaded Contracts");
    return true;
  }

  Future<List<Candidates>> loadCandidates() async {
    await contract_loaded;
    List<Candidates> list = [];
    int candidates_count = (await election.candidatesCount()).toInt();
    for (var i = 1; i <= candidates_count; i++) {
      list.add(await election.candidates(BigInt.from(i)));
    }
    return list;
  }
}
