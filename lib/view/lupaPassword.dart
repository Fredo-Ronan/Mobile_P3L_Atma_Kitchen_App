import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/customer_client.dart';
import 'package:mobile_app_atma_kitchen/database/user_client.dart';
import 'dart:math';

String generateRandomString(int length) {
  const charset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(
    List.generate(
      length,
      (index) => charset.codeUnitAt(random.nextInt(charset.length)),
    ),
  );
}

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF0182FF),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Lupa Password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  key: const Key('email'),
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Masukkan Email Anda",
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.person, color: Colors.grey),
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
                  validator: (value) {
                    if (value == "") {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    final scaffold = ScaffoldMessenger.of(context);

                    try {
                      var response =
                          await UserClient.getEmailCheck(emailController.text);
                      print(response);

                      if (response["EMAIL_CUSTOMER"] == emailController.text) {
                        String token = generateRandomString(10);

                        var sendToken = await UserClient.updateToken(
                            token, response["ID_CUSTOMER"]);

                        if (sendToken != null) {
                          String url_reset_password =
                              "https://p3-l-atma-kitchen-app.vercel.app/api/verify/$token/${response["ID_CUSTOMER"]}";

                          var sendEmail =
                              await UserClient.sendEmailResetPasword(
                                  emailController.text, url_reset_password);

                          if (sendEmail != null) {
                            scaffold.showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password reset link telah dikirim ke email Anda',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.pop(context);
                          }
                        }
                      }
                    } catch (e) {
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50.0),
                    backgroundColor: const Color(0xFF000000),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
