import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/presentation/forgot_password/forgot_password.dart';
import 'package:advance_course_flutter/presentation/login/login.dart';
import 'package:advance_course_flutter/presentation/main/main_view.dart';
import 'package:advance_course_flutter/presentation/onboarding/onboarding.dart';
import 'package:advance_course_flutter/presentation/register/register.dart';
import 'package:advance_course_flutter/presentation/resources/strings_manger.dart';
import 'package:advance_course_flutter/presentation/splash/splash.dart';
import 'package:advance_course_flutter/presentation/store_details/store_details.dart';
import 'package:flutter/material.dart';

class Routes
{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator
{
  static Route<dynamic> getRoute(RouteSettings routeSettings)
  {
    switch (routeSettings.name)
    {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute()
  {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.noRouteFound,
            ),
          ),
          body: const Center(
            child: Text(
                AppStrings.noRouteFound,
            ),
          ),
        ),
    );
  }
}