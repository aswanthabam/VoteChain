import 'package:http/http.dart';
import 'package:vote/Candidate.g.dart';
import 'package:vote/Permissions.g.dart';
import 'package:vote/VoteChain.g.dart';
import 'package:vote/Voter.g.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/contract_types.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class BlockchainClient {
  static late Web3Client client;
  static var httpClient = Client();
  static late Future<bool> contract_loaded;
  static late Future<bool> inited;

  static void init() {
    inited = initWeb3();
  }

  /*
    Function to initialize the Web3 Client
  */
  static Future<bool> initWeb3() async {
    try {
      client = Web3Client('http://192.168.18.17:7545', httpClient,
          socketConnector: () {
        return IOWebSocketChannel.connect('ws://192.168.18.17:7545')
            .cast<String>();
      });
      Global.logger.i("Successfully Initialized Web3 Client");
      return true;
    } catch (err) {
      Global.logger.e(
        "An unexpected error occured while initalizing Web3 Client : $err",
      );
      return false;
    }
  }

  /*
    Function that overlaps the loadContracts function for storing the Future state in contract_loaded
  */
  static void loadContracts() {
    contract_loaded = loadContracts2();
  }

  /*
    Load the contracts, which can be used to intract with the contract
  */
  static Future<bool> loadContracts2() async {
    if (!await BlockchainClient.inited) return false;
    try {
      // String abiString =
      //     await rootBundle.loadString("src/artifacts/Election.json");
      // var jsonAbi = jsonDecode(abiString);
      Contracts.voter = Voter(
          address: ContractAddress.voterAddress,
          client: BlockchainClient.client,
          chainId: 1337);
      Contracts.candidate = Candidate(
          address: ContractAddress.candidateAddress,
          client: BlockchainClient.client,
          chainId: 1337);
      ;
      Contracts.permissions = Permissions(
          address: ContractAddress.permissionsAddress,
          client: BlockchainClient.client,
          chainId: 1337);
      Contracts.votechain = VoteChain(
          address: ContractAddress.votechainAddress,
          client: BlockchainClient.client,
          chainId: 1337);
      Global.logger.i("Loaded Contracts");
      return true;
    } catch (err) {
      Global.logger.e(
        "An error occured while trying to load the contract : $err",
      );
      return false;
    }
  }
}

class Contracts {
  static Voter? voter;
  static Candidate? candidate;
  static Permissions? permissions;
  static VoteChain? votechain;
}
