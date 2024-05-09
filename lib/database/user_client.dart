import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_atma_kitchen/database/constants.dart';

class UserClient {
  static const String endpoint = '/api';
  static Future<String> login(String username, String password) async {
    try {
      var response = await http
          .post(
            Uri.https(url, '$endpoint/login'),
            headers: {"Content-Type": "application/json"},
            body: json.encode(
              {"username": username, "password": password},
            ),
          )
          .timeout(
            const Duration(seconds: 10),
          );

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> getEmailCheck(String email) async {
    try {
      var response = await http.post(
          Uri.https(url, '$endpoint/customer/auth/checkEmail'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}));

      return jsonDecode(response.body)["data"];
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> updateToken(
      String token, int id_customer) async {
    try {
      var respons = await http.post(
          Uri.https(url, '$endpoint/customer/auth/insertResetToken'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"token": token, "id_customer": id_customer}));

      return jsonDecode(respons.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> sendEmailResetPasword(
      String email, String url_reset_password) async {
    try {
      var response = await http.post(
          Uri.https(url, '$endpoint/customer/auth/sendEmailResetPass'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"email": email, "url_reset_password": url_reset_password}));

      return jsonDecode(response.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
