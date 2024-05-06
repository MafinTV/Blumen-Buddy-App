import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/pages/home.dart';
import 'package:test_app/shared_pref_manager.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  Color usernameBorderColor = const Color(0xFFDBFFB7);
  Color passwordBorderColor = const Color(0xFFDBFFB7);
  Color passwordRepeatBorderColor = const Color(0xFFDBFFB7);

  void checkRegister() {
    var error = 0;

    if (usernameController.text == "" || usernameController.text.length < 3) {
      usernameBorderColor = const Color(0xFFAC1616);
      error++;
    } else {
      usernameBorderColor = const Color(0xFFDBFFB7);
    }

    if (passwordController.text == "" || passwordController.text.length < 8) {
      passwordBorderColor = const Color(0xFFAC1616);
      error++;
    } else {
      passwordBorderColor = const Color(0xFFDBFFB7);
    }

    if (passwordController.text != passwordRepeatController.text) {
      passwordBorderColor = const Color(0xFFAC1616);
      passwordRepeatBorderColor = const Color(0xFFAC1616);
      error++;
    } else {
      passwordRepeatBorderColor = const Color(0xFFDBFFB7);
    }

    setState(() {});
    if (error == 0) {
      registerUser(usernameController.text, passwordController.text);
    }
  }

  Future<void> registerUser(String username, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://zentrale.ddns.net:3000/api/users/create'),
          body: json.encode({'user_name': username, 'password': password}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedPrefManager().setString('id', data['id'].toString());
        SharedPrefManager().setString('username', username);
        SharedPrefManager().setString('password', password);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/leafs.png',
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              child: Container(
                width: 100.w,
                height: 70.h,
                color: const Color(0xFF141313),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icon.png',
                              width: 25.w,
                            ),
                            const Text(
                              'Blumen-Buddy',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'ReemKufi',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(50),
                    SizedBox(
                      width: 80.w,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Benutzername',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'ReemKufi',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            style: const TextStyle(
                              fontFamily: 'ReemKufi',
                              color: Color(0xFFFFFFFF),
                              fontSize: 17,
                            ),
                            controller: usernameController,
                            cursorColor: const Color(0xFFDBFFB7),
                            maxLength: 16,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8.0),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: usernameBorderColor,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: usernameBorderColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          const Gap(30),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Passwort',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'ReemKufi',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            style: const TextStyle(
                              fontFamily: 'ReemKufi',
                              color: Color(0xFFFFFFFF),
                              fontSize: 17,
                            ),
                            controller: passwordController,
                            cursorColor: const Color(0xFFDBFFB7),
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8.0),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: passwordBorderColor,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: passwordBorderColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          const Gap(30),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Passwort wiederholen',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'ReemKufi',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            style: const TextStyle(
                              fontFamily: 'ReemKufi',
                              color: Color(0xFFFFFFFF),
                              fontSize: 17,
                            ),
                            controller: passwordRepeatController,
                            cursorColor: const Color(0xFFDBFFB7),
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8.0),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: passwordRepeatBorderColor,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: passwordRepeatBorderColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(60),
                    GestureDetector(
                      onTap: () => checkRegister(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Container(
                          color: const Color(0xFFE4FFC9),
                          width: 80.w,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(11.0),
                              child: Text(
                                'Registrieren',
                                style: TextStyle(
                                  fontFamily: 'ReemKufi',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
