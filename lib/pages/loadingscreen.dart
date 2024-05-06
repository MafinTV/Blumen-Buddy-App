import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/login.dart';
import 'package:test_app/shared_pref_manager.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    if (SharedPrefManager().getString('unit') == '') {
      SharedPrefManager().setString('unit', 'C');
    }

    if (SharedPrefManager().getString('id') != '' &&
        SharedPrefManager().getString('username') != '' &&
        SharedPrefManager().getString('password') != '') {
      loginUser(SharedPrefManager().getString('username'),
          SharedPrefManager().getString('password'));
    } else {
      Timer(const Duration(milliseconds: 1000), () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });
    }
  }

  Future<void> loginUser(String username, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://zentrale.ddns.net:3000/api/users/login'),
          body: json.encode({'user_name': username, 'password': password}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        Timer(const Duration(milliseconds: 1000), () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
        });
      } else {
        SharedPrefManager().remove('id');
        SharedPrefManager().remove('username');
        SharedPrefManager().remove('password');

        Timer(const Duration(milliseconds: 1000), () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Login()),
          );
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon.png'),
              const Gap(20),
              const Text(
                'Blumen-Buddy',
                style: TextStyle(
                  fontFamily: 'ReemKufi',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const Gap(300),
            ],
          ),
        ),
      ),
    );
  }
}
