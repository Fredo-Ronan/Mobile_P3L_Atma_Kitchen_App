import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class Hampers {
  final int? idHampers, hargaHampers;
  String? namaHampers, deskripsiHampers;
  List<Produk>? listProduk;

  Hampers(
      {this.deskripsiHampers,
      this.hargaHampers,
      this.idHampers,
      this.listProduk,
      this.namaHampers});
}
