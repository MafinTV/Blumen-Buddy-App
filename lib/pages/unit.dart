import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:test_app/shared_pref_manager.dart';

class Unit extends StatefulWidget {
  const Unit({super.key});

  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  var _dropdownValue = SharedPrefManager().getString('unit');

  void changeDropdown(String? value) {
    if (value is String) {
      SharedPrefManager().setString('unit', value);
      setState(() {
        _dropdownValue = value;
      });
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
                'Temperatureinheit',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 25,
                ),
              ),
            ),
            const Gap(30),
            SizedBox(
              width: 60.w,
              child: DropdownButton(
                items: const [
                  DropdownMenuItem<String>(
                    value: 'C',
                    child: Text('Grad Celsius'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'F',
                    child: Text('Grad Fahrenheit'),
                  ),
                ],
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                value: _dropdownValue,
                onChanged: (value) => changeDropdown(value),
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'ReemKufi',
                  fontSize: 18,
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF868686),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
