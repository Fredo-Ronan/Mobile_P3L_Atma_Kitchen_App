import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class ProdukReadyClient {
  static const String endpoint = '/api';
  static Future<List<Produk>> getProdukReady() async {
    try {
      var responseProdukReady = await http.get(
        Uri.https(url, '$endpoint/produk/getAllReadyStock'),
        headers: {"Content-Type": "application/json"},
      );

      // print(jsonDecode(responseProdukReady.body)["produkReadyStock"]);

      List<dynamic> arrayOfProdukReadyString =
          jsonDecode(responseProdukReady.body)["produkReadyStock"];

      List<Map<String, dynamic>> produkReadyListType =
          List<Map<String, dynamic>>.from(arrayOfProdukReadyString);

      List<Produk> listProdukReady = [];

      for (int i = 0; i < arrayOfProdukReadyString.length; i++) {
        listProdukReady
            .add(Produk.fromRawJson(jsonEncode(produkReadyListType[i])));
      }

      // for (var dataReady in listProdukReady) {
      //   print(dataReady.namaProduk);
      // }

      return listProdukReady;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
