import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_atma_kitchen/database/constants.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers_temp.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class HampersClient {
  static const String endpoint = '/api';
  static Future<List<Hampers>> getHampers() async {
    try {
      var responseDataHampers = await http.get(
        Uri.https(url, '$endpoint/hampers'),
        headers: {"Content-Type": "application/json"},
      );

      // print(jsonDecode(responseDataHampers.body)["dataHampers"]);

      List<dynamic> arrayOfHampersString =
          jsonDecode(responseDataHampers.body)["dataHampers"];

      List<Map<String, dynamic>> hampersListType =
          List<Map<String, dynamic>>.from(arrayOfHampersString);

      List<HampersTemp> listHampers = [];

      for (int i = 0; i < arrayOfHampersString.length; i++) {
        listHampers
            .add(HampersTemp.fromRawJson(jsonEncode(hampersListType[i])));
      }

      List<Hampers> listFinalHampers = [];

      for (var dataHampers in listHampers) {
        var responseDetilHampers = await http.get(
          Uri.https(url, '$endpoint/hampers/${dataHampers.idHampers}'),
          headers: {"Content-Type": "application/json"},
        );

        List<dynamic> detailProdukString =
            jsonDecode(responseDetilHampers.body)["detilHampers"];

        List<Map<String, dynamic>> detailProdukListType =
            List<Map<String, dynamic>>.from(detailProdukString);

        List<Produk> listProdukDetilHampers = [];

        for (int i = 0; i < detailProdukString.length; i++) {
          listProdukDetilHampers
              .add(Produk.fromRawJson(jsonEncode(detailProdukListType[i])));
        }

        listFinalHampers.add(Hampers(
            idHampers: dataHampers.idHampers,
            namaHampers: dataHampers.namaHampers,
            deskripsiHampers: dataHampers.deskripsiHampers,
            hargaHampers: dataHampers.hargaHampers,
            listProduk: listProdukDetilHampers));

        // for (int i = 0; i < listProdukDetilHampers.length; i++) {
        //   print(listProdukDetilHampers[i].namaProduk);
        // }
      }

      // for (var dataFinal in listFinalHampers) {
      //   print(dataFinal.namaHampers);
      // }

      return listFinalHampers;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
