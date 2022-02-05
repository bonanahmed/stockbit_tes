import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_tes/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Stockbit Clock Test',
      theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent,
          splashColor: Colors.teal),
      initialRoute: '/',
      home: SplashScreen(),
    );
  }
}
