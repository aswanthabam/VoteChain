import 'package:vote/services/api/api.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

enum FundAccountCallStatus {
  success("Successfully funded account."),
  failed(
      "There was an error while funding the account. Please try again later.");

  final String message;
  const FundAccountCallStatus(this.message);
}

class EthersCall extends APIClass {
  Future<FundAccountCallStatus> requestEthers() async {
    try {
      var val = await postCall(
          '/api/web3/ethers/fund/',
          {'to_address': VoteChainWallet.address!.hex},
          SystemConfig.localServer);
      print(val);
      if (val == null) {
        return FundAccountCallStatus.failed;
      }
      return FundAccountCallStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return FundAccountCallStatus.failed;
    }
  }
}
