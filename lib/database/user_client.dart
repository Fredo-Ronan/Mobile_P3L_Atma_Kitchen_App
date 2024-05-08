import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_app_atma_kitchen/database/constants.dart';

class UserClient {
  static const String endpoint = '/api';
  static Future<String> login(String username, String password) async {
    try {
      var response = await post(
        Uri.https(url, '$endpoint/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {"username": username, "password": password},
        ),
      ).timeout(
        const Duration(seconds: 10),
      );

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
