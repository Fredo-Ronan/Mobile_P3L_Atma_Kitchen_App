import 'dart:convert';

class MO {
  int? idKaryawan;
  String? namaKaryawan, emailKaryawan, alamatKaryawan, telpKaryawan, role;

  MO(
      {this.idKaryawan,
      this.namaKaryawan,
      this.emailKaryawan,
      this.alamatKaryawan,
      this.telpKaryawan,
      this.role});

  factory MO.fromRawJson(String str) => MO.fromJson(json.decode(str));
  factory MO.fromJson(Map<String, dynamic> json) => MO(
      idKaryawan: json["id_karyawan"],
      namaKaryawan: json["nama_karyawan"],
      emailKaryawan: json["email_karyawan"],
      alamatKaryawan: json["alamat_karyawan"],
      telpKaryawan: json["no_telp_karyawan"],
      role: json["role"]);
}
