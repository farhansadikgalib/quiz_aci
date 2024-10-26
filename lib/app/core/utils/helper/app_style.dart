import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle textHeaderStyle(
    {color = AppColors.headerTextColor,
    double fontSize = 30,
    fontWeight = FontWeight.w700}) {
  return GoogleFonts.inter(
      fontSize: fontSize, color: color, fontWeight: fontWeight);
}

TextStyle textAppBarStyle(
    {color = AppColors.appBarTextColor,
    double fontSize = 16,
    fontWeight = FontWeight.w600,
    bool isGrayColor = false}) {
  return GoogleFonts.inter(
      fontSize: fontSize,
      color: isGrayColor ? AppColors.gray : color,
      fontWeight: fontWeight);
}

TextStyle textRegularStyle(
    {color = AppColors.textColor,
    double fontSize = 14,
    fontWeight = FontWeight.normal,
    bool isGrayColor = false,
    bool isWhiteColor = false}) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
            ? AppColors.gray
            : color,
    fontWeight: fontWeight,
    //height: needHeight ? 1.0 : 0.0
  );
}

TextStyle drawerTextStyle(
    {color = AppColors.blackPure,
    double fontSize = 14,
    fontWeight = FontWeight.w600,
    bool isGrayColor = false,
    bool isWhiteColor = false}) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
            ? AppColors.gray
            : color,
    fontWeight: fontWeight,
    //height: needHeight ? 1.0 : 0.0
  );
}

TextStyle textButtonStyle(
    {color = AppColors.white,
    double fontSize = 18,
    fontWeight = FontWeight.w600}) {
  return GoogleFonts.inter(
      fontSize: fontSize, color: color, fontWeight: fontWeight);
}

TextStyle textLineStyle(
    {color = AppColors.textColor,
    double fontSize = 13,
    fontWeight = FontWeight.w600}) {
  return GoogleFonts.inter(
      fontSize: fontSize, color: color, fontWeight: fontWeight);
}

final hintStyle = GoogleFonts.inter(
    fontSize: 14, color: AppColors.inputColor, fontWeight: FontWeight.w500);
