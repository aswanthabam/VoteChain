import 'package:vote/Voter.g.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

enum VoterRegistrationStatus {
  success("Voter registration successfully completed!"),
  failed("An issue occured while registering, please contact admin.");

  final String message;
  const VoterRegistrationStatus(this.message);
}

class VoterHelper {
  late Web3Client client;
  late Voter voterContract;
  late Credentials credentials;
  VoterHelper() {
    voterContract = Contracts.voter!;
    credentials = VoteChainWallet.credentials!;
  }

  Future<VoterRegistrationStatus> registerVoter(VoterInfo voterInfo) async {
    try {
      await voterContract.registerVoter([
        [...voterInfo.personalInfo.toJson().values],
        [...voterInfo.contactInfo.toJson().values],
        [...voterInfo.currentAddress.toJson().values],
        [...voterInfo.permeantAddress.toJson().values],
        voterInfo.married,
        voterInfo.orphan
      ],
          credentials: credentials,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));

      return VoterRegistrationStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while registering voter : $err");
      return VoterRegistrationStatus.failed;
    }
  }
}
