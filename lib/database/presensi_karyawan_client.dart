import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/presensi_karyawan.dart';

class PresensiKaryawanClient {
  static const String endpoint = '/api/presensiKaryawan';

  static Future<List<Presensi>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)["data"];

      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create() async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(
      String statusPresensi, String idPresensi) async {
    try {
      var response = await put(
        Uri.https(url, '$endpoint/$idPresensi'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status_presensi": statusPresensi}),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
