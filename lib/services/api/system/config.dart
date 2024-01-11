import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

enum SystemConfigCallStatus {
  success("Successfully got the system configurations."),
  failed("An error occured while getting the system configurations");

  final String message;
  const SystemConfigCallStatus(this.message);
}

class SystemConfigCall extends APIClass {
  Future<SystemConfigCallStatus> getSystemConfigs() async {
    try {
      var val = await getCall<List<dynamic>>('/api/system/config');
      print(val);
      if (val == null || val.isEmpty) {
        return SystemConfigCallStatus.failed;
      }
      var val2 = val[0];
      SystemConfig.fromJson(val2);
      return SystemConfigCallStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return SystemConfigCallStatus.failed;
    }
  }
}
