import 'package:vote/contracts/Voter.g.dart';
import 'package:vote/contracts/VoterReader.g.dart';
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
  late VoterReader voterReaderContract;
  late Credentials credentials;
  VoterHelper() {
    voterContract = Contracts.voter!;
    voterReaderContract = Contracts.voterReader!;
    credentials = VoteChainWallet.credentials!;
  }
  Future<bool> fundAccount() async {
    double bal = await BlockchainClient.getBalance();
    try {
      print(credentials.address);
      var fumc = voterReaderContract.self.function('fundAccount');
      // ;
      print(await BlockchainClient.client.sendRawTransaction(
          await BlockchainClient.client.signTransaction(
              credentials,
              Transaction.callContract(
                  contract: voterReaderContract.self,
                  function: fumc,
                  parameters: []))));
      // print(await voterReaderContract.fundAccount(
      //   credentials: credentials,
      // ));
      Global.logger.i("Account funded with balance = $bal");
      return true;
    } catch (err) {
      Global.logger
          .e("An error occured while funding account (cur bal: $bal) : $err");
      return false;
    }
  }

  Future<VoterRegistrationStatus> registerVoter(VoterInfo voterInfo) async {
    try {
      await voterContract.registerVoter([
        [...voterInfo.personalInfo.toJson().values],
        [...voterInfo.contactInfo.toJson().values],
        [...voterInfo.currentAddress.toJson().values],
        [...voterInfo.permanentAddress.toJson().values],
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
