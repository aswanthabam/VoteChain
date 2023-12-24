// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vote/utils/types/contract_types.dart';

class Preferences {
  static late SharedPreferences pref;
  static late String rpcUrl;
  static late String helperUrl;
  static late String wsUrl;

  static String RPC_KEY = "rpcUrl";
  static String HELPER_KEY = "helperUrl";
  static String CONTRACT_KEY = 'contractAddress';
  static String WS_URL = "wsUrl";

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    rpcUrl = pref.getString(RPC_KEY) ?? "http://localhost:7545";
    helperUrl = pref.getString(HELPER_KEY) ?? "http://localhost:3131";
    ContractAddress.voterContractAddress =
        pref.getString("voterContractAddress") ??
            "0x1aBE68277AE236083947f2551FEe8b885efCA8f5";
    ContractAddress.votechainContractAddress =
        pref.getString("votechainContractAddress") ??
            "0x1aBE68277AE236083947f2551FEe8b885efCA8f5";
    ContractAddress.candidateContractAddress =
        pref.getString("candidateContractAddress") ??
            "0x1aBE68277AE236083947f2551FEe8b885efCA8f5";
    ContractAddress.permissionsContractAddress =
        pref.getString("permissionsContractAddress") ??
            "0x1aBE68277AE236083947f2551FEe8b885efCA8f5";
    wsUrl = pref.getString(WS_URL) ?? "ws://localhost:7545";
  }

  static void setRpcUrl(String val) {
    pref.setString(RPC_KEY, val);
    rpcUrl = val;
  }

  static void setHelperUrl(String val) {
    pref.setString(HELPER_KEY, val);
    helperUrl = val;
  }

  static void setConractAddress() {
    pref.setString(
        "voterContractAddress", ContractAddress.voterContractAddress ?? "");
    pref.setString("votechainContractAddress",
        ContractAddress.votechainContractAddress ?? "");
    pref.setString("candidateContractAddress",
        ContractAddress.candidateContractAddress ?? "");
    pref.setString("permissionsContractAddress",
        ContractAddress.permissionsContractAddress ?? "");
  }

  static void setWsUrl(String val) {
    pref.setString(WS_URL, val);
    wsUrl = val;
  }

  static Future<bool> reset() async {
    return await pref.clear();
  }
}
