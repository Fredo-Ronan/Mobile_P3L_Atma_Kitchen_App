import 'dart:convert';

class Karyawan {
  int? idKaryawan;
  String? namaKaryawan, emailKaryawan, alamatKaryawan, telpKaryawan, role;

  Karyawan(
      {this.idKaryawan,
      this.namaKaryawan,
      this.emailKaryawan,
      this.alamatKaryawan,
      this.telpKaryawan,
      this.role});

  factory Karyawan.fromRawJson(String str) => Karyawan.fromJson(json.decode(str));
  
  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
      idKaryawan: json["id_karyawan"],
      namaKaryawan: json["nama_karyawan"],
      emailKaryawan: json["email_karyawan"],
      alamatKaryawan: json["alamat_karyawan"],
      telpKaryawan: json["no_telp_karyawan"],
      role: json["role"]);
}
