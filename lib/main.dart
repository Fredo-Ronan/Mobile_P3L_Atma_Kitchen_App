import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';

void main() {
  runApp(MyApp(
    key: myAppKey,
  ));
}

final myAppKey = MyApp.createKey();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  // membuat global key untuk simpan state dari MyAppState
  static GlobalKey<MyAppState> createKey() => GlobalKey<MyAppState>();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
