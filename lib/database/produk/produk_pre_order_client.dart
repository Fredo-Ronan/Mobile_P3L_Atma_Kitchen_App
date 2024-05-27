import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class ProdukPreOrderClient {
  static const String endpoint = '/api';
  static Future<List<Produk>> getProdukPreOrder() async {
    try {
      var responsePreOrder = await http.get(
        Uri.https(url, '$endpoint/produk/getAllPreOrder'),
        headers: {"Content-Type": "application/json"},
      );

      List<dynamic> arrayOfPreOrderString =
          jsonDecode(responsePreOrder.body)['dataProdukPreorder'];

      List<Map<String, dynamic>> productListTyped =
          List<Map<String, dynamic>>.from(arrayOfPreOrderString);

      List<Produk> listProdukPreOrder = [];

      for (int i = 0; i < arrayOfPreOrderString.length; i++) {
        listProdukPreOrder
            .add(Produk.fromRawJson(jsonEncode(productListTyped[i])));
      }

      // for (var dataProduk in listProdukPreOrder) {
      //   print(dataProduk.namaProduk);
      // }

      return listProdukPreOrder;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
