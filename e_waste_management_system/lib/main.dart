// import 'package:e_waste_management_system/features/pages/startup_page.dart';
// import './features/citizen/citizen_additional_info_page.dart';
// import './features/auth/register_as.dart';
import 'package:flutter/material.dart';
import './features/citizen/citizen_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CitizenHomePage(),
    );
  }
}
