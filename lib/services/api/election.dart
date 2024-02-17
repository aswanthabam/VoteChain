import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

class ElectionCall extends APIClass {
  Future<bool> castVote({required String electionId}) async {
    try {
      var val = await postCall('/api/election/add-vote/',
          {'election': electionId}, SystemConfig.localServer);
      print(val);
      if (val == null) {
        return false;
      }
      return true;
    } catch (err) {
      Global.logger.e("An error occured while adding vote to db : $err");
      return false;
    }
  }

  Future<String?> getAccessKey(
      {required String scope, required String clientId}) async {
    try {
      var val = await postCall('/api/user/app/get-accesskey/',
          {'scope': scope, 'clientId': clientId}, SystemConfig.localServer);
      print(val);
      if (val == null) {
        return null;
      }
      try {
        var accessKey = val['data']['access_key'];
        return accessKey;
      } catch (err) {
        return null;
      }
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return null;
    }
  }
}
