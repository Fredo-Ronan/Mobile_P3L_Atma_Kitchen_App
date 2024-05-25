// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/customer/home.dart';
import 'package:mobile_app_atma_kitchen/view/customer/informasi_umum.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';
import 'package:mobile_app_atma_kitchen/view/mo/home/home_mo.dart';
import 'package:mobile_app_atma_kitchen/view/mo/home_mo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idCustomer = prefs.getString('id_customer') ?? '';
  String? idKaryawan = prefs.getString('id_karyawan') ?? '';
  String? role = prefs.getString('role') ?? '';

  runApp(
    MyApp(
      idCustomer: idCustomer,
      idKaryawan: idKaryawan,
      role: role,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? idCustomer;
  final String? idKaryawan;
  final String? role;

  const MyApp(
      {super.key,
      required this.idCustomer,
      required this.idKaryawan,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: idCustomer!.isEmpty && idKaryawan!.isEmpty
          ? LoginView()
          : role! == "MO"
              ? MainMOView(
                  selectedIndex: 0,
                )
              : InformasiUmum(),
    );
  }
}
