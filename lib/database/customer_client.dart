import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/customer.dart';

class CustomerClient {
  static const String endpoint = '/api';
  static Future<Customer> getCustomerData(String id) async {
    try {
      var response = await get(
        Uri.https(url, '$endpoint/customer/$id'),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 10));

      return Customer.fromJson(jsonDecode(response.body)["data"]);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
