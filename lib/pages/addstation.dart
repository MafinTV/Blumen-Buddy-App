import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/pages/claimstation.dart';

class AddStation extends StatefulWidget {
  const AddStation({super.key});

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  var loading = true;
  final List<Map<String, dynamic>> foundStations = [];

  @override
  void initState() {
    super.initState();
    getWifiName();
  }

  Future<void> getWifiName() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }

    final info = NetworkInfo();
    final name = await info.getWifiName();

    if (name!.startsWith('"')) {
      String nameWithoutQuotes = name.substring(1, name.length - 1);
      findStations(nameWithoutQuotes);
    } else {
      findStations(name);
    }
  }

  Future<void> findStations(String ssid) async {
    try {
      final response = await http.get(Uri.parse(
          'http://zentrale.ddns.net:3000/api/stations/findStations?ssid=$ssid'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        foundStations.clear();

        for (var station in data) {
          String stationSerialNumber = station['station_serial_number'];

          Map<String, dynamic> stationData = {
            'station_serial_number': stationSerialNumber
          };

          foundStations.add(stationData);
        }

        setState(() {
          loading = false;
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
        child: loading
            ? Column(
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
                  const Gap(200),
                  Image.asset(
                    'assets/loading.gif',
                    height: 16,
                  ),
                  const Gap(150),
                  const Text(
                    'Suche nach Wetterstationen in deiner Umgebung....',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'ReemKufi',
                      fontSize: 15,
                    ),
                  )
                ],
              )
            : Column(
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
                  const Gap(20),
                  SizedBox(
                    width: 90.w,
                    child: const Text(
                      'Gefundene Wetterstationen:',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'ReemKufi',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 70.h,
                        width: 80.w,
                        child: ListView.builder(
                          itemCount: foundStations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8,
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClaimStation(
                                      stationSerialNumber: foundStations[index]
                                          ['station_serial_number'],
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFC4C4C4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 16.0,
                                      left: 16.0,
                                      right: 0.0,
                                    ),
                                    child: Text(
                                      'Seriennummer: ${foundStations[index]['station_serial_number']}',
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'ReemKufi',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 90.w,
                    child: const Row(
                      children: [
                        Text(
                          'Wetterstation nicht gefunden? ',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'ReemKufi',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Hilfe',
                          style: TextStyle(
                            color: Color(0xFF165032),
                            fontFamily: 'ReemKufi',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
