import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

enum RegisterUserCallStatus {
  success("Successfully Synced with backend."),
  failed(
      "There was an error while syncing with backend. Please try again later.");

  final String message;
  const RegisterUserCallStatus(this.message);
}

class UserENC {
  String enc1;
  String enc2;
  UserENC({required this.enc1, required this.enc2});

  static UserENC fromJson(Map<String, dynamic> json) {
    return UserENC(enc1: json['ec1'], enc2: json['ec2']);
  }
}

class UserAuthCall extends APIClass {
  Future<UserENC?> loginUser({required String aadhar}) async {
    try {
      var val = await postCall('/api/user/auth/login/', {'aadhar': aadhar},
          SystemConfig.localServer);
      print(val);
      if (val == null) {
        return null;
      }
      return UserENC.fromJson(val['data']);
    } catch (err) {
      Global.logger.e("An error occured while getting user auth : $err");
      return null;
    }
  }

  Future<RegisterUserCallStatus> registerUser(
      {required String uid,
      required String aadhar,
      required String enc1,
      required String enc2}) async {
    try {
      var val = await postCall(
          '/api/user/auth/register/',
          {'uid': uid, 'aadhar': aadhar, 'enc1': enc1, 'enc2': enc2},
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
