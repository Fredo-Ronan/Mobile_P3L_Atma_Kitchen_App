// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MOView extends StatefulWidget {
  const MOView({super.key});

  @override
  State<MOView> createState() => _MOViewState();
}

class _MOViewState extends State<MOView> {
  String? idKaryawan;

  void getUserData() async {
    // disini juga nanti buat get data karyawan mekanismenya sama aja kayak yang di customer yang di file home.dart di folder customer
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      idKaryawan = prefs.getString('id_karyawan');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MO View! ID_KARYAWAN : $idKaryawan',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  pushLogout(context);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('id_karyawan');
                  prefs.remove('role');
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil Logout!'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushLogout(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginView(),
      ),
    );
  }
}
