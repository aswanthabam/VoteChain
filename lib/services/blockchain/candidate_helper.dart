import 'package:vote/services/api/candidates.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:web3dart/web3dart.dart';

class CandidateInfo {
  final CandidateBlockchainInfo info;
  final CandidateProfile profile;

  CandidateInfo({required this.info, required this.profile});
}

class CandidateHelper {
  Future<bool> withdrawNomination(int electionId) async {
    try {
      var res = await Contracts.candidate?.withdrawNomination(
          BigInt.from(electionId),
          credentials: VoteChainWallet.credentials!,
          transaction: Transaction(
              maxPriorityFeePerGas: EtherAmount.inWei(BigInt.zero)));
      Global.logger.i("Withdraw nomination response: $res");
      return true;
    } catch (err) {
      Global.logger.e("An error occured while withdrawing nomination: $err");
      return false;
    }
  }

  Future<List<CandidateInfo>> getEligibleCandidates(int electionId) async {
    // Get the list of candidates who are eligible for the election
    List<CandidateInfo> candidates = [];
    try {
      List<dynamic>? res =
          await Contracts.candidate?.getCandidates(BigInt.from(electionId));

      if (res != null && res.isNotEmpty) {
        Global.logger.i("Eligible candidates: $res");
        for (var candidate in res) {
          CandidateBlockchainInfo info =
              CandidateBlockchainInfo.fromList(candidate);
          Global.logger.i(info);
          CandidateProfile? profile = await CandidateCall()
              .getCandidateProfile(candidateAddress: info.address.hex);
          if (profile != null) {
            Global.logger.i("Candidate profile: $profile");
            candidates.add(CandidateInfo(info: info, profile: profile));
          } else {
            Global.logger.i("No profile found for candidate: $info");
          }
        }
      } else {
        Global.logger.i("No eligible candidates found, $res");
      }
    } catch (err) {
      Global.logger
          .e("An error occured while getting eligible candidates: $err");
    }
    return candidates;
  }
}
