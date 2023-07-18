import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;
  static late String rpcUrl;
  static late String helperUrl;
  static late String contractAddress;

  static String RPC_KEY = "rpcUrl";
  static String HELPER_KEY = "helperUrl";
  static String CONTRACT_KEY = 'contractAddress';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    // pref.clear();
    rpcUrl = pref.getString(RPC_KEY) ?? "http://192.168.18.2:7545";
    helperUrl = pref.getString(HELPER_KEY) ?? "http://192.168.18.2:3131";
    contractAddress = pref.getString(CONTRACT_KEY) ??
        "0x6ea72486a146e2b3cd3d1d5908b3107eb72f4991";
  }

  static void setRpcUrl(String val) {
    pref.setString(RPC_KEY, val);
    rpcUrl = val;
  }

  static void setHelperUrl(String val) {
    pref.setString(HELPER_KEY, val);
    helperUrl = val;
  }

  static void setConractAddress(String val) {
    pref.setString(CONTRACT_KEY, val);
    contractAddress = val;
  }

  static Future<bool> reset() async {
    return await pref.clear();
  }
}
