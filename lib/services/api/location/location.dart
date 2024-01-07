import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

class LocationCall extends APIClass {
  Future<List<State>> getStates({String? search}) async {
    try {
      var val = await getCall<List<dynamic>>(
          '/api/location/states/list/?${search != null ? 'search=$search' : ''}');
      if (val == null) {
        return [];
      }
      List<State> states = [];
      for (var i in val) {
        states.add(State.fromJson(i));
      }
      return states;
    } catch (err) {
      Global.logger.e("An error occured while getting state details : $err");
      return [];
    }
  }

  Future<List<District>> getDistricts({String? stateId, String? search}) async {
    try {
      var val = await getCall<List<dynamic>>(
          '/api/location/districts/list/?${search != null ? 'search=$search&' : ''}${stateId != null ? 'state_id=$stateId' : ''}');
      if (val == null) {
        return [];
      }
      print(val);
      List<District> districts = [];
      for (var i in val) {
        districts.add(District.fromJson(i));
      }
      return districts;
    } catch (err) {
      Global.logger.e("An error occured while getting district details : $err");
      return [];
    }
  }

  Future<List<Constituency>> getConstituencies(
      {String? districtId, String? search}) async {
    try {
      var val = await getCall<List<dynamic>>(
          '/api/location/constituencies/list/?${search != null ? 'search=$search&' : ''}${districtId != null ? 'district_id=$districtId' : ''}');
      if (val == null) {
        return [];
      }
      print(val);
      List<Constituency> constituencies = [];
      for (var i in val) {
        constituencies.add(Constituency.fromJson(i));
      }
      return constituencies;
    } catch (err) {
      Global.logger.e("An error occured while getting district details : $err");
      return [];
    }
  }
}
