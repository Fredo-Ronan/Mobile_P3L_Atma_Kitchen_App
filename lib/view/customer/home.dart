// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/customer_client.dart';
import 'package:mobile_app_atma_kitchen/entity/customer.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Customer? dataCustomer;
  bool isLoading = false;
  bool isLoadingButton = false;

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // ini pake query lagi ke api khusus cuma buat get data customer aja, biar ga berantakan dan enak nanti klo debugging
      // query berdasarkan ID_CUSTOMER nya gtu sih buat get data customer dari tabel customer gtu
      Customer fetchedData =
          await CustomerClient.getCustomerData(prefs.getString('id_customer')!);

      setState(() {
        dataCustomer = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Gagal Mengambil Data Customer!'),
        duration: Duration(seconds: 5),
      ));
    }
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
                children: const [
                  Text(
                    'Customer View!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [CircularProgressIndicator()],
                    )
                  : Column(
                      children: [
                        Text('Id customer : ${dataCustomer!.idCustomer}'),
                        Text('Nama Customer : ${dataCustomer!.namaCustomer}'),
                        Text('Email Customer : ${dataCustomer!.emailCustomer}'),
                        Text('Tanggal Lahir : ${dataCustomer!.tanggalLahir}'),
                        Text('Telepon : ${dataCustomer!.telepon}'),
                        Text('Saldo : ${dataCustomer!.saldo}'),
                        Text('Total Poin : ${dataCustomer!.totalPoin}')
                      ],
                    ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoadingButton = true;
                  });
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
                child: isLoadingButton
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.0, vertical: 2.0),
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
