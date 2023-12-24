import 'package:vote/services/api/api.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

enum RegisterUserCallStatus {
  success("Successfully Synced with backend."),
  failed(
      "There was an error while syncing with backend. Please try again later.");

  final String message;
  const RegisterUserCallStatus(this.message);
}

class UserAuthCall extends APIClass {
  Future<RegisterUserCallStatus> registerUser(
      {required String uid,
      required String aadhar,
      required String enc1,
      required String enc2,
      required String password}) async {
    try {
      var val = await postCall(
          '/api/user/auth/register/',
          {
            'uid': uid,
            'aadhar': aadhar,
            'enc1': enc1,
            'enc2': enc2,
            'password': password
          },
          SystemConfig.localServer);
      print(val);
      if (val == null) {
        return RegisterUserCallStatus.failed;
      }
      return RegisterUserCallStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return RegisterUserCallStatus.failed;
    }
  }
}
