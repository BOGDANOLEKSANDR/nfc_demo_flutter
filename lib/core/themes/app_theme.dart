import 'package:animations/animations.dart';
import 'package:flutter/scheduler.dart';
import 'package:nfc_demo/common_libs.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme() {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: MaterialColor(AppColor.accent.value, getSwatch(AppColor.accent)),
      fontFamily: 'Dosis',
      primaryColor: AppColor.lightPrimary,
      backgroundColor: AppColor.lightSecondaryBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: ThemeText.getLightTextTheme(),
      scaffoldBackgroundColor: AppColor.lightBackground,
      dialogBackgroundColor: AppColor.lightBackground,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.lightBackground,
        iconTheme: IconThemeData(color: AppColor.lightPrimary),
        actionsIconTheme: IconThemeData(color: AppColor.lightPrimary),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
          TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
        },
      ),
    );
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        secondary: AppColor.accent,
        surface: AppColor.accentSurface,
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: MaterialColor(AppColor.accent.shade600.value, getSwatch(AppColor.accent.shade600)),
      fontFamily: 'Dosis',
      primaryColor: AppColor.darkPrimary,
      backgroundColor: AppColor.darkSecondaryBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: ThemeText.getDarkTextTheme(),
      scaffoldBackgroundColor: AppColor.darkBackground,
      // dialogBackgroundColor: AppColor.darkBackground,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.darkBackground,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
          TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
        },
      ),
    );
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        secondary: AppColor.accent.shade600,
        surface: AppColor.accentSurface,
      ),
    );
  }

  static Brightness get currentSystemBrightness => SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: currentSystemBrightness == Brightness.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            currentSystemBrightness == Brightness.light ? AppColor.lightBackground : AppColor.darkBackground,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light ? AppColor.lightBackground : AppColor.darkBackground,
      ));
    }
  }
}

extension AppColorExtras on ThemeData {
  Color get iconColor => brightness == Brightness.light ? AppColor.lightIcon : AppColor.darkIcon;

  Color get subtitleColor => brightness == Brightness.light ? AppColor.lightSubtitle : AppColor.darkSubtitle;

  Color get secondaryBackgroundColor =>
      brightness == Brightness.light ? AppColor.lightSecondaryBackground : AppColor.darkSecondaryBackground;

  Color get cellBackgroundColor =>
      brightness == Brightness.light ? AppColor.lightCellBackground : AppColor.darkCellBackground;

  Color get cellForegroundColor =>
      brightness == Brightness.light ? AppColor.lightCellBackground.shade600 : AppColor.darkCellBackground.shade400;

  // Color get loaderBackgroundColor =>
  //     brightness == Brightness.light ? AppColor.darkSecondaryBackground.shade50.withOpacity(0.5) : scaffoldBackgroundColor.shade200.withOpacity(0.9);
  Color get loaderBackgroundColor =>
      brightness == Brightness.light ? Colors.black.withOpacity(0.1) : Colors.white.withOpacity(0.8);

  Color get overlayBackgroundColor =>
      brightness == Brightness.light ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7);

  Color get blueBackgroundColor => brightness == Brightness.light
      ? AppColor.blueBackground.shade100.withOpacity(0.5)
      : AppColor.blueBackground.shade600.withOpacity(0.4);

  Color get greenBackgroundColor => brightness == Brightness.light
      ? AppColor.greenBackground.shade100.withOpacity(0.5)
      : AppColor.greenBackground.shade600.withOpacity(0.4);

  Color get redBackgroundColor => brightness == Brightness.light
      ? AppColor.redBackground.shade100.withOpacity(0.5)
      : AppColor.redBackground.shade600.withOpacity(0.4);

  Color get yellowBackgroundColor => brightness == Brightness.light
      ? AppColor.yellowBackground.shade100
      : AppColor.yellowBackground.shade600.withOpacity(0.4);

  Color get finishedBadgeColor =>
      brightness == Brightness.light ? AppColor.blueGray.shade300 : AppColor.blueGray.shade600;

  Color get queueBadgeColor => brightness == Brightness.light ? AppColor.amber : AppColor.amber.shade600;

  Color get reservedBadgeColor => brightness == Brightness.light ? AppColor.teal : AppColor.teal.shade600;

  Color get unconfirmedBadgeColor => brightness == Brightness.light ? AppColor.pink.shade400 : AppColor.pink.shade600;

  Color get fullBadgeColor => brightness == Brightness.light ? AppColor.error.shade400 : AppColor.error.shade600;

  TextStyle? get listBodyText1 => textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get listBodyText2 => textTheme.bodyText2?.copyWith(color: subtitleColor);
}
