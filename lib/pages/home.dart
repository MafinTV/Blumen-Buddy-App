import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:test_app/pages/addstation.dart';
import 'package:test_app/pages/settings.dart';
import 'package:test_app/shared_pref_manager.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> foundStations = [];
  Timer? _timer;

  Future<void> getUserStations() async {
    try {
      final response = await http.post(
          Uri.parse(
              'http://zentrale.ddns.net:3000/api/stations/getUserStations'),
          body: json.encode({
            'user_name': SharedPrefManager().getString('username'),
            'password': SharedPrefManager().getString('password')
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        foundStations.clear();

        for (var station in data) {
          String stationName = station['station_name'];
          String stationSerialNumber = station['station_serial_number'];
          String temp = station['station_temp_value'].toString();
          String soilMoist = station['station_soil_moist_value'].toString();
          String airMoist = station['station_air_moist_value'].toString();

          Map<String, dynamic> stationData = {
            'station_name': stationName,
            'station_serial_number': stationSerialNumber,
            'station_temp_value': temp,
            'station_soil_moist_value': soilMoist,
            'station_air_moist_value': airMoist
          };

          foundStations.add(stationData);
        }

        setState(() {});
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getUserStations();
    _timer =
        Timer.periodic(const Duration(seconds: 10), (_) => getUserStations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313),
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ellipse.png"),
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.settings_outlined,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hallo, ${SharedPrefManager().getString('username')}',
                          style: const TextStyle(
                            fontFamily: 'ReemKufi',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: const Color(0xFF000000),
                      width: 1.5,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.0,
                          bottom: 4.0,
                          left: 4.0,
                          right: 2.0,
                        ),
                        child: Icon(Icons.search_sharp),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'ReemKufi',
                            fontSize: 17,
                          ),
                          cursorColor: Color(0xFF000000),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                              top: 4.0,
                              bottom: 4.0,
                              left: 2.0,
                              right: 4.0,
                            ),
                            hintText: 'Suche',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(60),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deine Wetterstationen',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ReemKufi',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const Gap(35),
                      SizedBox(
                        height: 70.h,
                        child: ListView.builder(
                          itemCount: foundStations.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return index == foundStations.length
                                ? GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddStation(),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF7C7C7C),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFC4C4C4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100.0)),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Neue Wetterstation registrieren..',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'ReemKufi',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF7C7C7C),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 6.0,
                                                  left: 8.0,
                                                ),
                                                child: Text(
                                                  foundStations[index]
                                                      ['station_name'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'ReemKufi',
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 6.0,
                                                  right: 8.0,
                                                ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFF41E052),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100.0)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              foundStations[index]
                                                  ['station_serial_number'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'ReemKufi',
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8.0,
                                                  left: 8.0,
                                                  right: 14.0,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  child: Image.asset(
                                                      'assets/child.png'),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    SharedPrefManager()
                                                                .getString(
                                                                    'unit') ==
                                                            'C'
                                                        ? 'Temperatur: ${foundStations[index]['station_temp_value']}°C'
                                                        : 'Temperatur: ${double.parse(foundStations[index]['station_temp_value']) * 1.8 + 32}°F',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'ReemKufi',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Luftfeuchtigkeit: ${foundStations[index]['station_air_moist_value']}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'ReemKufi',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bodenfeuchtigkeit: ${foundStations[index]['station_soil_moist_value']}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'ReemKufi',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
