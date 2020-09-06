import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';

final appTheme = ThemeData(
  backgroundColor: AppColors.gray3,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  primaryColorDark: AppColors.primaryColor,
  primaryColorLight: AppColors.primaryColor,
  // scaffoldBackgroundColor: AppColors.backgroundColor,
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontSize: 21.0,
      color: AppColors.bodyText2Color,
    ),
    // bodyText1: TextStyle(
    //   fontSize: 21.0,
    //   color: AppColors.bodyText2Color,
    // ),
    // headline1: TextStyle(
    //   fontSize: 21.0,
    //   color: AppColors.bodyText2Color,
    // ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
