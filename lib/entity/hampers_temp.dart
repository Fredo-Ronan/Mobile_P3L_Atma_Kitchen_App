import 'dart:convert';

class HampersTemp {
  final int? idHampers, hargaHampers;
  String? namaHampers, deskripsiHampers;

  HampersTemp(
      {this.deskripsiHampers,
      this.hargaHampers,
      this.idHampers,
      this.namaHampers});

  // menerima JSON dari API yang nanti di convert jadi object HampersTemp
  factory HampersTemp.fromRawJson(String str) =>
      HampersTemp.fromJson(json.decode(str));

  factory HampersTemp.fromJson(Map<String, dynamic> json) => HampersTemp(
        idHampers: json["ID_HAMPERS"],
        namaHampers: json["NAMA_HAMPERS"],
        hargaHampers: json['HARGA_HAMPERS'],
        deskripsiHampers: json["DESKRIPSI_HAMPERS"],
      );
}
