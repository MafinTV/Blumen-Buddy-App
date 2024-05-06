import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:test_app/pages/aboutus.dart';
import 'package:test_app/pages/deleteaccount.dart';
import 'package:test_app/pages/loadingscreen.dart';
import 'package:test_app/pages/unit.dart';
import 'package:test_app/shared_pref_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void logOut() {
    SharedPrefManager().remove('id');
    SharedPrefManager().remove('username');
    SharedPrefManager().remove('password');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );
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
              width: 80.w,
              child: const Text(
                'Einstellungen',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Unit(),
                ),
              ),
              child: Container(
                width: 100.w,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFFFFFFF)),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 80.w,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 32.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Temperatureinheit',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFFFFFFF),
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeleteAccount(),
                ),
              ),
              child: Container(
                width: 100.w,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFFFFFFF)),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 80.w,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 32.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Account löschen',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFFFFFFF),
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUs(),
                ),
              ),
              child: Container(
                width: 100.w,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFFFFFFF)),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 80.w,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 32.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Über uns',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFFFFFFF),
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(70),
            GestureDetector(
              onTap: () => logOut(),
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
                    'Ausloggen',
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
