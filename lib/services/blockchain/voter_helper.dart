import 'package:vote/Voter.g.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

class VoterHelper {
  late Web3Client client;
  late Voter voterContract;
  late Credentials credentials;
  VoterHelper(Voter voter) {
    print("Initializing Voter Helper");
    print(Contracts.voter);
    voterContract = voter;
    credentials = VoteChainWallet.credentials!;
  }

  Future<void> registerVoter(VoterInfo voterInfo) async {
    ContractFunction reg = voterContract.self.function("registerVoter");
    // BlockchainClient.init();
    // await BlockchainClient.inited!;

    // print(await BlockchainClient.client!.sendTransaction(
    //     credentials,
    //     Transaction.callContract(
    //         contract: voterContract.self,
    //         function: reg,
    //         parameters: [
    //           [
    //             [...voterInfo.personalInfo.toJson().values],
    //             [...voterInfo.contactInfo.toJson().values],
    //             [...voterInfo.currentAddress.toJson().values],
    //             [...voterInfo.permeantAddress.toJson().values],
    //             voterInfo.married,
    //             voterInfo.orphan
    //           ]
    //         ])));
    print(await voterContract.registerVoter([
      [...voterInfo.personalInfo.toJson().values],
      [...voterInfo.contactInfo.toJson().values],
      [...voterInfo.currentAddress.toJson().values],
      [...voterInfo.permeantAddress.toJson().values],
      voterInfo.married,
      voterInfo.orphan
    ],
        credentials: credentials,
        transaction: Transaction(
            maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0))));
  }
}
