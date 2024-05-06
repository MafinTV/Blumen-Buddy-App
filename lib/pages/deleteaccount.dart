import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/pages/loadingscreen.dart';
import 'package:test_app/shared_pref_manager.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  Future<void> deleteAccount() async {
    try {
      final response = await http
          .delete(Uri.parse('http://zentrale.ddns.net:3000/api/users/delete'),
              body: json.encode({
                'user_name': SharedPrefManager().getString('username'),
                'password': SharedPrefManager().getString('password')
              }),
              headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        SharedPrefManager().remove('id');
        SharedPrefManager().remove('username');
        SharedPrefManager().remove('password');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoadingScreen()),
        );
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 0,
                    right: 32,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Account löschen',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 25,
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Wenn Sie Ihren Account löschen, werden alle ihre Daten gelöscht und können nicht wiederhergestellt werden.',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 15,
                ),
              ),
            ),
            const Gap(70),
            GestureDetector(
              onTap: () async {
                await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          content: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF868686),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 80.w,
                            height: 20.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Möchten Sie ihren Account löschen?',
                                  style: TextStyle(
                                    color: Color(0xFF141313),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () => deleteAccount(),
                                      child: const Text(
                                        'Löschen',
                                        style: TextStyle(
                                          color: Color(0xFFE71515),
                                          fontFamily: 'ReemKufi',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Abbruch',
                                        style: TextStyle(
                                          color: Color(0xFF3B2DDF),
                                          fontFamily: 'ReemKufi',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x55AC1616),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Account löschen',
                    style: TextStyle(
                      color: Color(0xFFAC1616),
                      fontFamily: 'ReemKufi',
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
