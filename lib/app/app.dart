import 'package:advance_course_flutter/data/network/app_api.dart';
import 'package:advance_course_flutter/presentation/resources/routes_manger.dart';
import 'package:advance_course_flutter/presentation/resources/theme_manger.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getAppTheme(),
    );
  }
}
