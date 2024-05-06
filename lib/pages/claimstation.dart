import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/pages/home.dart';
import 'package:test_app/shared_pref_manager.dart';

class ClaimStation extends StatefulWidget {
  const ClaimStation({
    super.key,
    required this.stationSerialNumber,
  });

  final String stationSerialNumber;

  @override
  State<ClaimStation> createState() => _ClaimStationState();
}

class _ClaimStationState extends State<ClaimStation> {
  TextEditingController stationNameController = TextEditingController();

  var tempSensor = true;
  var airMoistSensor = true;
  var soilMoistSensor = true;

  void invertSensor(String sensor) {
    if (sensor == "temp") {
      setState(() {
        tempSensor = !tempSensor;
      });
    } else if (sensor == "air") {
      setState(() {
        airMoistSensor = !airMoistSensor;
      });
    } else if (sensor == "soil") {
      setState(() {
        soilMoistSensor = !soilMoistSensor;
      });
    }
  }

  void checkClaim() {
    if (stationNameController.text != "" &&
        stationNameController.text.length <= 16) {
      claimStation();
    }
  }

  Future<void> claimStation() async {
    try {
      final response = await http.post(
          Uri.parse('http://zentrale.ddns.net:3000/api/stations/claimStation'),
          body: json.encode({
            'station_serial_number': widget.stationSerialNumber,
            'station_name': stationNameController.text,
            'station_temp_toggle': tempSensor ? "1" : "0",
            'station_soil_moist_toggle': soilMoistSensor ? "1" : "0",
            'station_air_moist_toggle': airMoistSensor ? "1" : "0",
            'user_name': SharedPrefManager().getString('username'),
            'password': SharedPrefManager().getString('password')
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
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
    stationNameController.dispose();
    super.dispose();
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
                'Registriere eine neue Wetterstation',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 22,
                ),
              ),
            ),
            const Gap(40),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Gib deiner Wetterstation einen Namen!',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: SizedBox(
                  width: 80.w,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            bottom: 16.0,
                            left: 16.0,
                            right: 0.0,
                          ),
                          child: Text(
                            'Name: ',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              fontFamily: 'ReemKufi',
                              fontSize: 17,
                              color: Color(0xFFFFFFFF),
                            ),
                            controller: stationNameController,
                            maxLength: 16,
                            cursorColor: const Color(0xFFFFFFFF),
                            decoration: const InputDecoration(
                              counterText: '',
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                top: 4.0,
                                bottom: 4.0,
                                left: 2.0,
                                right: 4.0,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Welche Sensoren sollen aktiv sein?',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Temperatursensor',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: GestureDetector(
                  onTap: () => invertSensor("temp"),
                  child: SizedBox(
                    width: 90.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 16.0,
                              left: 16.0,
                              right: 0.0,
                            ),
                            child: Text(
                              'Status: ',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'ReemKufi',
                                fontSize: 17,
                              ),
                            ),
                          ),
                          tempSensor
                              ? const Text(
                                  'Aktiv',
                                  style: TextStyle(
                                    color: Color(0xFF45D954),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                )
                              : const Text(
                                  'Nicht aktiv',
                                  style: TextStyle(
                                    color: Color(0xFFE04141),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Luftfeuchtigkeitssensor',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: GestureDetector(
                  onTap: () => invertSensor("air"),
                  child: SizedBox(
                    width: 90.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 16.0,
                              left: 16.0,
                              right: 0.0,
                            ),
                            child: Text(
                              'Status: ',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'ReemKufi',
                                fontSize: 17,
                              ),
                            ),
                          ),
                          airMoistSensor
                              ? const Text(
                                  'Aktiv',
                                  style: TextStyle(
                                    color: Color(0xFF45D954),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                )
                              : const Text(
                                  'Nicht aktiv',
                                  style: TextStyle(
                                    color: Color(0xFFE04141),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              width: 90.w,
              child: const Text(
                'Bodenfeuchtigkeitssensor',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: GestureDetector(
                  onTap: () => invertSensor("soil"),
                  child: SizedBox(
                    width: 90.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 16.0,
                              left: 16.0,
                              right: 0.0,
                            ),
                            child: Text(
                              'Status: ',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'ReemKufi',
                                fontSize: 17,
                              ),
                            ),
                          ),
                          soilMoistSensor
                              ? const Text(
                                  'Aktiv',
                                  style: TextStyle(
                                    color: Color(0xFF45D954),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                )
                              : const Text(
                                  'Nicht aktiv',
                                  style: TextStyle(
                                    color: Color(0xFFE04141),
                                    fontFamily: 'ReemKufi',
                                    fontSize: 17,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(40),
            GestureDetector(
              onTap: () => checkClaim(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF165032),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    'Hinzufügen',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'ReemKufi',
                      fontSize: 18,
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
