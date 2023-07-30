import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'preferences.dart';
import '../components/dialog.dart';
import 'dart:convert';

class API {
  static String api_message = "";
  static Future<bool> registerUser(
      String address, int uid, String password) async {
    // print("Address : " + address);
    try {
      final res =
          await post(Uri.parse(Preferences.helperUrl + "/api/public/register"),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "address": address,
                "uid": uid,
                "key": password,
              }));
      if (res.statusCode != 200) {
        // print(res.body);
        return false;
      } else {
        api_message = json.decode(res.body)["description"];
        return true;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }
}
