import 'dart:convert';

class LaporanStokBahan {
  String? namaBahan, satuan;
  int? stok;

  LaporanStokBahan({this.namaBahan, this.satuan, this.stok});

  // menerima JSON dari API yang nanti di convert jadi object Laporan Stok Bahan
  factory LaporanStokBahan.fromRawJson(String str) =>
      LaporanStokBahan.fromJson(json.decode(str));

  factory LaporanStokBahan.fromJson(Map<String, dynamic> json) =>
      LaporanStokBahan(
        namaBahan: json["NAMA_BAHAN"],
        stok: json["STOK_BAHAN"],
        satuan: json["SATUAN"],
      );
}
