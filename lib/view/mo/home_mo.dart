// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/login/login.dart';

class MOView extends StatefulWidget {
  const MOView({super.key});

  @override
  State<MOView> createState() => _MOViewState();
}

class _MOViewState extends State<MOView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MO View!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  pushLogout(context);
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