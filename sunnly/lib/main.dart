import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunnly/pages/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(textTheme: GoogleFonts.antonTextTheme()),
      home: const WeatherPage(),
    );
  }
}
