import 'package:artbox/ui/member.dart';
import 'package:artbox/ui/view.dart';
import 'package:flutter/material.dart';
import 'package:artbox/ui/onBoarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art-Box',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnBoarding(),
    );
  }
}