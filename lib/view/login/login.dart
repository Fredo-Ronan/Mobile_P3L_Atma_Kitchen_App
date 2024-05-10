import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/user_client.dart';
import 'package:mobile_app_atma_kitchen/entity/customer.dart';
import 'package:mobile_app_atma_kitchen/entity/karyawan.dart';
import 'package:mobile_app_atma_kitchen/view/customer/home.dart';
import 'package:mobile_app_atma_kitchen/view/lupa_password.dart';
import 'package:mobile_app_atma_kitchen/view/mo/home_mo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> openUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Gagal Open Browser');
    }
  }

  bool passwordInvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0182FF),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // reverse: true,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),

                //Username
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      key: const Key('username'),
                      controller: usernameController,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username tidak boleh kosong";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Masukkan Username Anda",
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ),

                //Password
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                          left: 25,
                          top: 25,
                        ),
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        )),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      key: const Key('password'),
                      controller: passwordController,
                      onChanged: (value) => {
                        setState(() {
                          passwordController.text = value;
                        })
                      },
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: passwordInvisible,
                      decoration: InputDecoration(
                        labelText: "Masukkan Password Anda",
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordInvisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passwordInvisible = !passwordInvisible;
                              },
                            );
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: TextButton(
                      child: const Text(
                        "Lupa Password?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                      },
                    ),
                  ),
                ),

                //Login button
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 375,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        void navPush(MaterialPageRoute route) {
                          Navigator.pushReplacement(context, route);
                        }

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            String responseLogin = await UserClient.login(
                                usernameController.text,
                                passwordController.text);

                            // todo add entity to store user data according to is the user is Admin/MO/Owner or Customer

                            if (jsonDecode(responseLogin)["role"] == "MO" &&
                                jsonDecode(responseLogin)["status"] == "OK") {
                              // user yang login adalah MO
                              Karyawan managerOperasional = Karyawan.fromJson(
                                  jsonDecode(responseLogin)["data"]);

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'id_karyawan',
                                  managerOperasional.idKaryawan
                                      .toString()); // sementara placeholder
                              prefs.setString('role', 'MO');

                              navPush(
                                MaterialPageRoute(
                                    builder: (_) => const MOView()),
                              );

                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil Login!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else if (jsonDecode(responseLogin)["role"] ==
                                    "Customer" &&
                                jsonDecode(responseLogin)["status"] == "OK") {
                              // user yang login adalah Customer
                              Customer customer = Customer.fromJson(
                                  jsonDecode(responseLogin)["data"]);

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'id_customer',
                                  customer.idCustomer
                                      .toString()); // sementara placeholder
                              prefs.setString('role', 'Customer');

                              navPush(
                                MaterialPageRoute(
                                    builder: (_) => const HomeView()),
                              );

                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil Login!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else if (jsonDecode(responseLogin)["status"] ==
                                "NOT OK") {
                              // username atau password salah
                              setState(() {
                                isLoading = false;
                              });
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Username atau Password salah!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else if (jsonDecode(responseLogin)["status"] ==
                                "NOT VERIFIED") {
                              // email belum diverifikasi
                              setState(() {
                                isLoading = false;
                              });
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Belum Verifikasi Email!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            }
                          } catch (e) {
                            // print(e.toString());
                            scaffoldMessenger.showSnackBar(
                              const SnackBar(
                                content: Text('Gagal Login!'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => const HomeView(),
                        //   ),
                        // );
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'Log in',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ),

                //Tombol ke halaman register
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      openUrl(Uri.parse(
                          'https://p3-l-atma-kitchen-app.vercel.app/sign-up'));
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anda Belum Mempunyai Akun? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
