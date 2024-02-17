import 'package:vote/provider/voter_provider.dart';
import 'package:vote/services/api/ethers/ethers.dart';
import 'package:vote/services/api/user.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/encryption.dart';

class RegisterCallbackResult {
  final bool success;
  final String message;
  final String? faceId;
  final String? appKey;
  RegisterCallbackResult(
      {required this.success, required this.message, this.faceId, this.appKey});
}

Future<RegisterCallbackResult> submitRegister(VoterModal modal) async {
  VoterHelper helper = VoterHelper(); // initalize voter helper
  var res = await EthersCall().requestEthers(); // request to fund the account
  if (res != FundAccountCallStatus.success) {
    // There was an error with the fund account call
    return RegisterCallbackResult(success: false, message: res.message);
  }

  var sts = await helper.registerVoter(
      modal.voterInfo, modal.constituency); // register voter with blockchain

  if (sts == VoterRegistrationStatus.success) {
    VoteChainWallet.saveWallet(modal.pin); // save wallet to local storage

    // register user with the server, only the backup details are send like encrypted mnemonic
    var sts2 = await UserAuthCall().registerUser(
        uid: modal.aadharNumber,
        aadhar: modal.aadharNumber,
        enc1: await encrypt(VoteChainWallet.mnemonic!.sublist(4, 8).join(' '),
                modal.password) ??
            "errorstring:enc",
        enc2: await encrypt(VoteChainWallet.mnemonic!.sublist(8, 12).join(' '),
                modal.password) ??
            "erronstring:enc",
        voterAddress: VoteChainWallet.address!);
    if (!sts2.status) {
      // there was an error with the register user call
      return RegisterCallbackResult(success: false, message: sts2.message);
    }
    await helper.fetchInfo(); // get the user registration from the blockchain
    return RegisterCallbackResult(
        success: true,
        message: sts.message,
        faceId: sts2.faceId,
        appKey: sts2.appKey);
  }
  return RegisterCallbackResult(success: false, message: sts.message);
}
