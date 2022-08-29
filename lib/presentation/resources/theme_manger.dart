import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/font_manger.dart';
import 'package:advance_course_flutter/presentation/resources/styles_manger.dart';
import 'package:advance_course_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme()
{
  return ThemeData(

    // main color of app
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.primaryOpacity70,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1, // disable button
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManger.grey),
    splashColor: ColorManger.primaryOpacity70, // ripple color

    // card view
    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,

    ),

    // appBar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManger.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManger.primaryOpacity70,
      titleTextStyle: getRegularStyle(
          color: ColorManger.white,
          fontSize: AppSize.s16,
      ),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.primaryOpacity70,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManger.white),
        primary: ColorManger.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
          color: ColorManger.darkGrey,
          fontSize: FontSize.s16,
      ),
      headline2: getRegularStyle(
        color: ColorManger.white,
        fontSize: FontSize.s16,
      ),
      headline3: getBoldStyle(
        color: ColorManger.primary,
        fontSize: FontSize.s16,
      ),
      subtitle1: getMediumStyle(
        color: ColorManger.lightGrey,
        fontSize: FontSize.s14,
      ),
      subtitle2: getMediumStyle(
        color: ColorManger.primary,
        fontSize: FontSize.s12
      ),
      caption: getRegularStyle(color: ColorManger.grey1,),
      bodyText1: getRegularStyle(color: ColorManger.grey,),
    ),

    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      // hint style
      hintStyle: getRegularStyle(color: ColorManger.grey1),

      // label style
      labelStyle: getMediumStyle(color: ColorManger.darkGrey),

      // error style
      errorStyle: getRegularStyle(color: ColorManger.error),

      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.grey,
          width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManger.primary,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManger.error,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManger.primary,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

    ),

  );
}