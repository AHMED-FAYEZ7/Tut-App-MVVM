import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  int appState = 0 ;

  static final MyApp instance = MyApp._internal();  // singleton

  factory MyApp() => instance;  //factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
