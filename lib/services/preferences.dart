// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;
  static late String rpcUrl;
  static late String helperUrl;
  static late String? contractAddress;
  static late String wsUrl;

  static String RPC_KEY = "rpcUrl";
  static String HELPER_KEY = "helperUrl";
  static String CONTRACT_KEY = 'contractAddress';
  static String WS_URL = "wsUrl";

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    rpcUrl = pref.getString(RPC_KEY) ?? "http://192.168.18.5:7545";
    helperUrl = pref.getString(HELPER_KEY) ?? "http://192.168.18.5:3131";
    contractAddress = pref.getString(CONTRACT_KEY); // ??
    //"0x1aBE68277AE236083947f2551FEe8b885efCA8f5";
    wsUrl = pref.getString(WS_URL) ?? "ws://192.168.18.5:7545";
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

  static void setWsUrl(String val) {
    pref.setString(WS_URL, val);
    wsUrl = val;
  }

  static Future<bool> reset() async {
    return await pref.clear();
  }
}
