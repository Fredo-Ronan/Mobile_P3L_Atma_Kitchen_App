// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/customer_client.dart';
import 'package:mobile_app_atma_kitchen/entity/customer.dart';
import 'package:mobile_app_atma_kitchen/view/customer/informasi_umum.dart';
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
      bottomNavigationBar: _BottomBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 411,
                  height: 75,
                  color: Color.fromRGBO(12, 57, 235, 0.91),
                  child: Center(
                    child: Text(
                      'Profile Customer',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
                      Container(
                          margin: EdgeInsets.only(bottom: 10, top: 30),
                          padding: EdgeInsets.all(10),
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 198, 198),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Nama Customer : ${dataCustomer!.namaCustomer}',
                            style: TextStyle(fontSize: 14),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 198, 198),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Email Customer : ${dataCustomer!.emailCustomer}',
                            style: TextStyle(fontSize: 14),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 198, 198),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Tanggal Lahir : ${dataCustomer!.tanggalLahir}',
                            style: TextStyle(fontSize: 14),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                            bottom: 50,
                          ),
                          padding: EdgeInsets.all(10),
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 198, 198),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Telepon : ${dataCustomer!.telepon}',
                            style: TextStyle(fontSize: 14),
                          )),
                    ],
                  ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoadingButton = true;
                });
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                pushLogout(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
            )
          ],
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

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.blue,
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InformasiUmum()));
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InformasiUmum()));
            },
            icon: const Icon(
              Icons.cake,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
