import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

class CandidateCall extends APIClass {
  Future<CandidateProfile?> getCandidateProfile(
      {required String candidateAddress}) async {
    try {
      var val = await getCallNormal('/api/candidate/profile/',
          {'candidateAddress': candidateAddress}, SystemConfig.localServer);
      print(val);
      if (val == null) {
        return null;
      }
      return CandidateProfile.fromJson(val['data']);
    } catch (err) {
      Global.logger
          .e("An error occured while getting candidate profile : $err");
      return null;
    }
  }
}
