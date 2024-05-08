import 'dart:convert';

class Customer {
  final int? idCustomer, saldo, totalPoin;
  String? namaCustomer, emailCustomer, tanggalLahir, role, telepon;

  Customer(
      {this.idCustomer,
      this.saldo,
      this.totalPoin,
      this.namaCustomer,
      this.emailCustomer,
      this.role,
      this.tanggalLahir,
      this.telepon});

  // menerima JSON dari API yang nanti diconvert jadi object Customer
  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        idCustomer: json["id_customer"],
        namaCustomer: json["nama_customer"],
        emailCustomer: json["email_customer"],
        tanggalLahir: json["tanggal_lahir"],
        telepon: json["telepon"],
        saldo: json["saldo"],
        totalPoin: json["total_poin"],
      );

  // membuat json dari object Customer untuk dikirim melalui API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id_customer": idCustomer,
    "nama_customer": namaCustomer,
    "email_customer": emailCustomer,
    "tanggal_lahir": tanggalLahir,
    "telepon": telepon,
    "saldo": saldo,
    "total_poin": totalPoin
  };
}
