// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/karyawan_client.dart';
import 'package:mobile_app_atma_kitchen/entity/karyawan.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerView extends StatefulWidget {
  const OwnerView({super.key});

  @override
  State<OwnerView> createState() => _OwnerViewState();
}

class _OwnerViewState extends State<OwnerView> {
  Karyawan? dataKaryawan;
  bool isLoading = false;
  bool isLoadingButton = false;

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    // disini juga nanti buat get data karyawan mekanismenya sama aja kayak yang di customer yang di file home.dart di folder customer
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Karyawan fetchedDataKaryawan =
        await KaryawanClient.getKaryawanData(prefs.getString('id_karyawan')!);

    setState(() {
      dataKaryawan = fetchedDataKaryawan;
      isLoading = false;
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
                    'Owner View',
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
                      children: [const CircularProgressIndicator()],
                    )
                  : Column(
                      children: [
                        Text('Id karyawan : ${dataKaryawan!.idKaryawan}'),
                        Text('Nama Karyawan : ${dataKaryawan!.namaKaryawan}'),
                        Text('Email Karyawan : ${dataKaryawan!.emailKaryawan}'),
                        Text(
                            'Alamat Karyawan : ${dataKaryawan!.alamatKaryawan}'),
                        Text('No Telp : ${dataKaryawan!.telpKaryawan}'),
                        Text('Role : ${dataKaryawan!.role}')
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
                  prefs.remove('id_karyawan');
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
