import 'dart:convert';

class Presensi {
  final int? idPresensi, idKaryawan;
  String? tanggalPresensi, statusPresensi, namaKaryawan;

  Presensi(
      {this.idPresensi,
      this.idKaryawan,
      this.tanggalPresensi,
      this.statusPresensi,
      this.namaKaryawan});

  factory Presensi.fromRawJson(String str) =>
      Presensi.fromJson(json.decode(str));
  factory Presensi.fromJson(Map<String, dynamic> json) => Presensi(
        idPresensi: json["id_presensi_karyawan"],
        idKaryawan: json["id_karyawan"],
        tanggalPresensi: json["tanggal_presensi"],
        statusPresensi: json["status_presensi"],
        namaKaryawan: json['nama_karyawan'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_presensi_karyawan": idPresensi,
        "id_karyawan": idKaryawan,
        "tanggal_presensi": tanggalPresensi,
        "status_presensi": statusPresensi,
        "nama_karyawan": namaKaryawan
      };
}
