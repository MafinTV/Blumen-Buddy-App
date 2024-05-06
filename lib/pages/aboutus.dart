import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                'Über uns',
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
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 15,
                ),
                'Willkommen bei Blumen-Buddy, Ihrem zuverlässigen Begleiter für ein optimiertes Pflanzenwachstum und ortsgebundener Wetterverfolgung. Unser Team, bestehend aus den Entwicklern Marvin Plagge und Jolina Sadegor, hat sich während unseres Themenfeldes Projektmanagement in der Schule zusammengeschlossen, um innovative Lösungen für den Fachkräftemangel in Gärtnereien zu schaffen.',
              ),
            ),
            const Gap(16),
            SizedBox(
              width: 90.w,
              child: const Text(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 15,
                ),
                'Unsere Wetterstation bietet nicht nur präzise ortsgebundene Daten, sondern integriert auch eine intelligente App, die es den Benutzern ermöglicht, ihre Pflanzen besser zu verstehen und zu pflegen. Von der Überwachung der Luftfeuchtigkeit und der Temperatur bis hin zur Bodenfeuchte bietet Blumen-Buddy alles, was Sie benötigen, um Ihre grünen Freunde glücklich und gesund zu halten.',
              ),
            ),
            const Gap(16),
            SizedBox(
              width: 90.w,
              child: const Text(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 15,
                ),
                'Bei Blumen-Buddy stehen Benutzerfreundlichkeit, Qualität und Kundenzufriedenheit an erster Stelle. Wir sind stolz darauf, ein Produkt anzubieten, das nicht nur den Bedürfnissen unserer Kunden entspricht, sondern auch einen Beitrag zur Förderung eines akut auftretendem Problem, dem Fachkräftemangel, beiträgt.',
              ),
            ),
            const Gap(16),
            SizedBox(
              width: 90.w,
              child: const Text(
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReemKufi',
                  fontSize: 15,
                ),
                'Entdecken Sie noch heute die Vorteile von Blumen-Buddy und lassen Sie Ihre Pflanzen in voller Blüte erstrahlen!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
