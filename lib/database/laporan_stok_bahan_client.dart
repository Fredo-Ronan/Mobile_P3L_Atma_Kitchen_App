import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/laporan_stok_bahan.dart';

class LaporanStokBahanClient {
  static const String endpoint = '/api/laporan/stokBahanBaku/1';

  static Future<List<LaporanStokBahan>> fetchLaporanStok() async {
    try {
      var response = await get(Uri.https(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<dynamic> arrayOfStokBahan = json.decode(response.body)["data"];

      List<Map<String, dynamic>> stokBahanListType =
          List<Map<String, dynamic>>.from(arrayOfStokBahan);

      List<LaporanStokBahan> listStokBahan = [];

      for (int i = 0; i < arrayOfStokBahan.length; i++) {
        listStokBahan.add(
            LaporanStokBahan.fromRawJson(jsonEncode(stokBahanListType[i])));
      }

      // for (var dataStok in listStokBahan) {
      //   print(dataStok.namaBahan);
      //   print(dataStok.satuan);
      //   print(dataStok.stok);
      // }

      return listStokBahan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
