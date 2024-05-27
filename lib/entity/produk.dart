import 'dart:convert';

class Produk {
  final int? idProduk, idPenitipProduk, idResep, hargaProduk, stok;
  String? namaProduk,
      jenisMakanan,
      deskripsiProduk,
      loyang,
      statusProduk,
      jenisProduk,
      gambarProduk;

  Produk(
      {this.idProduk,
      this.idPenitipProduk,
      this.idResep,
      this.deskripsiProduk,
      this.gambarProduk,
      this.hargaProduk,
      this.jenisMakanan,
      this.jenisProduk,
      this.loyang,
      this.namaProduk,
      this.statusProduk,
      this.stok});

  // menerima JSON dari API yang nanti di convert jadi object Produk
  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json["ID_PRODUK"],
        idPenitipProduk: json["ID_PENITIP_PRODUK"],
        idResep: json["ID_RESEP"],
        deskripsiProduk: json["DESKRIPSI_PRODUK"],
        gambarProduk: json["GAMBAR_PRODUK"],
        hargaProduk: json["HARGA_PRODUK"],
        jenisMakanan: json["JENIS_MAKANAN"],
        jenisProduk: json["JENIS_PRODUK"],
        loyang: json["LOYANG"],
        namaProduk: json["NAMA_PRODUK"],
        statusProduk: json["STATUS_PRODUK"],
        stok: json["STOK"],
      );

  // membuat json dari object Produk untuk dikirim melalui API
  String toRawJson() => json.encode(toJson()); // ini juga harusnya tidak perlu soalnya di mobile cuma menampilkan saja

  Map<String, dynamic> toJson() => {
    // harusnya tidak perlu soalnya di mobile cuma menampilkan aja
  };
}
