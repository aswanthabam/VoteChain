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
      var val = await getCall('/api/system/config');
      if (val == null) {
        return SystemConfigCallStatus.failed;
      }
      print(val);
      SystemConfig.fromJson(val);
      return SystemConfigCallStatus.success;
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return SystemConfigCallStatus.failed;
    }
  }
}
