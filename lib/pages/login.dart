import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/register.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/shared_pref_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(String username, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://zentrale.ddns.net:3000/api/users/login'),
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
                                fontFamily: 'ReemKufi',
                                color: Color(0xFFFFFFFF),
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
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFDBFFB7),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFDBFFB7),
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
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFDBFFB7),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFDBFFB7),
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
                      onTap: () => loginUser(
                          usernameController.text, passwordController.text),
                      child: ClipRRect(
                        // ? remove ClipRRect and use BoxDecoration
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
                                'Anmelden',
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
                    const Gap(90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Kein Konto? ',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'ReemKufi',
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          ),
                          child: const Text(
                            'Registrieren',
                            style: TextStyle(
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                              color: Color(0xFF66C409),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
