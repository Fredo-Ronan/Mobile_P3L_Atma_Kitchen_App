// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? idCustomer;

  void getUserData() async {
    // disini mungkin nanti query lagi ke api khusus cuma buat get data customer aja, bikin route lagi aja biar ga berantakan dan enak nanti klo debugging
    // query berdasarkan ID_CUSTOMER nya gtu sih buat get data customer dari tabel customer gtu
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      idCustomer = prefs.getString('id_customer')!;
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
                    'Customer View! ID_CUSTOMER : $idCustomer',
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
                  prefs.remove('id_customer');
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
