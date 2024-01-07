// Class for intracting with the API Server

import 'package:http/http.dart';
import 'package:vote/services/global.dart';
import '../preferences.dart';
import 'dart:convert';

class APIClass {
  String host = "https://votechain-backend.vercel.app";

  Future<T?> getCall<T>(String route) async {
    Response response = await get(Uri.parse(host + route));
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] as T;
    }
    return null;
  }

  Future<Map<String, dynamic>?> postCall(
      String route, Map<String, dynamic>? data, String? hostAddress) async {
    Response response =
        await post(Uri.parse((hostAddress ?? host) + route), body: data);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}

class API {
  static String apiMessage =
      ""; // Variable that stores the final result from the API. refreshes after each request
  static String statusMsg =
      ""; // The status ms send by the server (eg: erro_invalid_request)
  /*
    Method to register a user inside the helper server
    Accepts the address of the current wallet, uid and the password 
  */
  static Future<bool> registerUser(
      String address, int uid, String password) async {
    try {
      final res =
          await post(Uri.parse("${Preferences.helperUrl}/api/public/register"),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "address": address,
                "uid": uid,
                "key": password,
              }));
      if (res.statusCode != 200) {
        Global.logger.e(
            "An unexpected responce received from the API while registering a user",
            stackTrace: StackTrace.fromString("Responce : ${res.body}"));
        return false;
      } else {
        apiMessage = json.decode(res.body)["description"];
        return true;
      }
    } catch (err) {
      Global.logger.e("An unexpected error occured while registering a user",
          stackTrace: StackTrace.fromString(err.toString()));
      return false;
    }
  }
}
