import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _dosisTextTheme => GoogleFonts.dosisTextTheme();

  static TextStyle? get _lightTitleLarge => _dosisTextTheme.titleLarge?.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColor.darkPrimary,
      );

  static TextStyle? get _lightHeadlineSmall => _dosisTextTheme.headlineSmall?.copyWith(
        color: AppColor.darkPrimary,
      );

  static TextStyle? get _lightHeadlineMedium => _dosisTextTheme.headlineMedium?.copyWith(
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        color: AppColor.darkPrimary,
      );

  static TextStyle? get _lightDisplaySmall => _dosisTextTheme.displaySmall?.copyWith(
        fontFamily: 'Dosis',
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        color: AppColor.darkPrimary,
      );

  static TextStyle? get _lightTitleMedium => _dosisTextTheme.titleMedium?.copyWith(
        fontSize: 17.0,
        fontFamily: 'Dosis',
        color: AppColor.darkPrimary,
      );

  static TextStyle? get _lightTitleSmall => _dosisTextTheme.titleSmall?.copyWith(
        fontFamily: 'Dosis',
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: AppColor.darkPrimary,
        height: 1.5,
      );

  static TextStyle? get _lightButton => _dosisTextTheme.button?.copyWith(
        fontFamily: 'Dosis',
        color: Colors.white,
      );

  static TextStyle? get _lightBodyLarge => _dosisTextTheme.bodyLarge?.copyWith(
        color: Colors.white,
      );

  static TextStyle? get _lightBodyMedium => _dosisTextTheme.bodyMedium?.copyWith(
        color: Colors.white,
      );

  static TextStyle? get _lightBodySmall => _dosisTextTheme.bodySmall?.copyWith(
        fontFamily: 'Dosis',
        color: Colors.white,
        fontSize: 13.0,
        height: 1.5,
      );

  static TextStyle? get _darkTitleLarge => _lightTitleLarge?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkHeadlineSmall => _lightHeadlineSmall?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkHeadlineMedium => _lightHeadlineMedium?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkDisplaySmall => _lightDisplaySmall?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkTitleMedium => _lightTitleMedium?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkTitleSmall => _lightTitleSmall?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkBodyLarge => _lightBodyLarge?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkBodyMedium => _lightBodyMedium?.copyWith(color: AppColor.primary);

  static TextStyle? get _darkBodySmall => _lightBodySmall?.copyWith(color: AppColor.primary);

  static getDarkTextTheme() => TextTheme(
        displaySmall: _lightDisplaySmall,
        headlineMedium: _lightHeadlineMedium,
        headlineSmall: _lightHeadlineSmall,
        titleLarge: _lightTitleLarge,
        titleMedium: _lightTitleMedium,
        titleSmall: _lightTitleSmall,
        bodyLarge: _lightBodyLarge,
        bodyMedium: _lightBodyMedium,
        bodySmall: _lightBodySmall,
        labelLarge: _lightButton,
      );

  static getLightTextTheme() => TextTheme(
        displaySmall: _darkDisplaySmall,
        headlineMedium: _darkHeadlineMedium,
        headlineSmall: _darkHeadlineSmall,
        titleLarge: _darkTitleLarge,
        titleMedium: _darkTitleMedium,
        titleSmall: _darkTitleSmall,
        bodyLarge: _darkBodyLarge,
        bodyMedium: _darkBodyMedium,
        bodySmall: _darkBodySmall,
        labelLarge: _lightButton,
      );
}
