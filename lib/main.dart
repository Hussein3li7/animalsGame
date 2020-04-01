import 'package:animals/Service/admobService.dart';
import 'package:flutter/material.dart';

import 'gui/mainApp.dart';

void main() {
  runApp(MyApp());
  AdmobService().getAppId();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePageApp(),
    );
  }
}
