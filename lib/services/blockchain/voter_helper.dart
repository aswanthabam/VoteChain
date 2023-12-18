import 'package:vote/Voter.g.dart';
import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

class VoterHelper {
  late EthereumAddress _voterContractAddress;
  late Web3Client client;
  late Voter voterContract;
  late Credentials credentials;
  VoterHelper(EthereumAddress voterContractAddress, Web3Client client,
      Credentials cred) {
    _voterContractAddress = voterContractAddress;
    voterContract = Voter(address: _voterContractAddress, client: client);
    credentials = cred;
  }

  Future<void> registerVoter(VoterInfo voterInfo) async {
    await voterContract.registerVoter([voterInfo], credentials: credentials);
  }
}
