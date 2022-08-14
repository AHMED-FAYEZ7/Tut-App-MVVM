import 'package:advance_course_flutter/presentaion/resources/font_manger.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    String fontFamily,
    Color color,
    ){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    color: color,
  );
}

// regular style

TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}){
  return _getTextStyle(
    fontSize,
    FontWeightManger.regular,
    FontConstants.fontFamily,
    color,
  );
}

// light text style

TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}){
  return _getTextStyle(
    fontSize,
    FontWeightManger.light,
    FontConstants.fontFamily,
    color,
  );
}

// bold style

TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}){
  return _getTextStyle(
    fontSize,
    FontWeightManger.bold,
    FontConstants.fontFamily,
    color,
  );
}

// semiBold style

TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}){
  return _getTextStyle(
    fontSize,
    FontWeightManger.semiBold,
    FontConstants.fontFamily,
    color,
  );
}

// medium style

TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  required Color color,
}){
  return _getTextStyle(
    fontSize,
    FontWeightManger.medium,
    FontConstants.fontFamily,
    color,
  );
}