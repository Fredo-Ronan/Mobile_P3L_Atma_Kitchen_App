import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/karyawan.dart';

class KaryawanClient {
  static const String endpoint = '/api';
  static Future<Karyawan> getKaryawanData(String id) async {
    try {
      var response = await get(Uri.https(url, '$endpoint/karyawan/$id'),
              headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 10));

      return Karyawan.fromJson(jsonDecode(response.body)["data"]);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
