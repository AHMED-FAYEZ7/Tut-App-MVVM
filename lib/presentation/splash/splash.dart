import 'dart:async';

import 'package:advance_course_flutter/app/app_prefs.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/main.dart';
import 'package:advance_course_flutter/presentation/resources/assets_manager.dart';
import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/routes_manger.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay()
  {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async
  {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
    if(isUserLoggedIn){
        // navigate to main()
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    }else{
    _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) {
      if(isOnBoardingScreenViewed){
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }else{
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    });
  }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
