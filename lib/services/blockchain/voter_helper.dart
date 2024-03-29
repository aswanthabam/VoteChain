import 'package:vote/contracts/Voter.g.dart';
import 'package:vote/contracts/VoterReader.g.dart';
import 'package:vote/services/api/election.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

enum VoterRegistrationStatus {
  success("Voter registration successfully completed!"),
  failed("An issue occured while registering, please contact admin.");

  final String message;
  const VoterRegistrationStatus(this.message);
}

enum VoterStatus {
  registered("Voter is registered, and waiting for approval."),
  verified("Voter is verified and can vote.");

  final String message;
  const VoterStatus(this.message);
}

class VoterHelper {
  late Web3Client client;
  late Voter voterContract;
  late VoterReader voterReaderContract;
  late Credentials credentials;
  static VoterInfo? voterInfo;
  static VoterStatus? voterRegistrationStatus;

  VoterHelper() {
    voterContract = Contracts.voter!;
    voterReaderContract = Contracts.voterReader!;
    credentials = VoteChainWallet.credentials!;
  }
  Future<bool> fundAccount() async {
    double bal = await BlockchainClient.getBalance();
    try {
      var fumc = voterReaderContract.self.function('fundAccount');
      // ;
      await BlockchainClient.client.sendRawTransaction(
          await BlockchainClient.client.signTransaction(
              credentials,
              Transaction.callContract(
                  contract: voterReaderContract.self,
                  function: fumc,
                  parameters: [])));
      Global.logger.i("Account funded with balance = $bal");
      return true;
    } catch (err) {
      Global.logger
          .e("An error occured while funding account (cur bal: $bal) : $err");
      return false;
    }
  }

  Future<BigInt?> getVoterID() async {
    try {
      var val = await voterContract.voter_id_linker(VoteChainWallet.address!);
      return val;
    } catch (err) {
      Global.logger.e("An error occured while fetching voter id : $err");
      return null;
    }
  }

  Future<VoterInfo?> fetchInfo() async {
    try {
      var func = voterReaderContract.self.function('getVoterInfo');
      var info = await BlockchainClient.client.call(
          contract: voterReaderContract.self,
          function: func,
          sender: VoteChainWallet.address!,
          params: []);
      if (info.isEmpty) {
        return null;
      }
      VoterHelper.voterInfo = VoterInfo.fromList(info[0]);

      return VoterHelper.voterInfo;
    } catch (err) {
      Global.logger.e("An error occured while fetching voter info : $err");
      return null;
    }
  }

  Future<VoterStatus?> fetchRegistrationStatus() async {
    try {
      var func = voterReaderContract.self.function('getRegistrationStatus');
      var info = await BlockchainClient.client.call(
          contract: voterReaderContract.self,
          function: func,
          sender: VoteChainWallet.address!,
          params: []);
      if (info.isEmpty) {
        return null;
      }
      print(info);
      VoterHelper.voterRegistrationStatus = info[0] == BigInt.zero
          ? VoterStatus.registered
          : VoterStatus.verified;
      return VoterHelper.voterRegistrationStatus;
    } catch (err) {
      Global.logger.e("An error occured while fetching voter info : $err");
      return null;
    }
  }

  Future<VoterRegistrationStatus> registerVoter(
      VoterInfo voterInfo, String constituency) async {
    try {
      await voterContract.registerVoter([
        voterInfo.aadharNumber,
        [...voterInfo.personalInfo.toJson().values],
        [...voterInfo.contactInfo.toJson().values],
        [...voterInfo.currentAddress.toJson().values],
        [...voterInfo.permanentAddress.toJson().values],
        voterInfo.married,
        voterInfo.orphan,
        constituency
      ], constituency,
          credentials: credentials,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));

      return VoterRegistrationStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while registering voter : $err");
      return VoterRegistrationStatus.failed;
    }
  }

  Future<bool> vote(EthereumAddress candidateAddress, int electionId) async {
    try {
      await Contracts.votechain?.vote(BigInt.from(electionId), candidateAddress,
          credentials: credentials,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 0)));
      await ElectionCall().castVote(electionId: electionId.toString());
      return true;
    } catch (err) {
      Global.logger.e("An error occured while voting : $err");
      return false;
    }
  }

  Future<List<Result>?> getResults(int electionId) async {
    try {
      var val = await Contracts.votechain?.getResults(BigInt.from(electionId));
      Global.logger.f("Election results : $val");
      if (val == null) {
        return null;
      }
      List<Result> results = [];
      for (var r in val) {
        results.add(Result.fromList(r));
      }
      return results;
    } catch (err) {
      Global.logger
          .e("An error occured while fetching election results : $err");
      return null;
    }
  }

  Future<bool> isVoted(int electionId) async {
    try {
      var val = await Contracts.votechain
          ?.voterVoted(BigInt.from(electionId), VoteChainWallet.address!);
      Global.logger.f("Voter voted status : $val");
      return val!;
    } catch (err) {
      Global.logger.e("An error occured while fetching voter id : $err");
      return false;
    }
  }

  Future<int> totalNominations(int electionId) async {
    try {
      var count =
          await Contracts.candidate?.nominationsCount(BigInt.from(electionId));
      return count!.toInt();
    } catch (err) {
      Global.logger
          .e("An error occured while fetching nominations count : $err");
      return -1;
    }
  }

  Future<int> totalVotersCount(String constituency) async {
    try {
      var count = await Contracts.voter?.constituency_voter_count(constituency);
      return count!.toInt();
    } catch (err) {
      Global.logger.e("An error occured while fetching voters count : $err");
      return -1;
    }
  }

  Future<int> totalVotes(int electionId) async {
    try {
      var count =
          await Contracts.votechain?.getTotalVoteCount(BigInt.from(electionId));
      return count!.toInt();
    } catch (err) {
      Global.logger.e("An error occured while fetching voters count : $err");
      return -1;
    }
  }

  Future<int> candidatesCount(int electionId) async {
    try {
      var count =
          await Contracts.candidate?.candidateCount(BigInt.from(electionId));
      return count!.toInt();
    } catch (err) {
      Global.logger
          .e("An error occured while fetching candidates count : $err");
      return -1;
    }
  }
}
