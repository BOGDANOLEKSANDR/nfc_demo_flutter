import 'package:nfc_demo/presentation/screens/main/main_screen.dart';
import 'package:nfc_demo/presentation/screens/read_tag/read_tag_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:nfc_demo/presentation/alert/alert_cubit.dart';
import 'package:nfc_demo/presentation/router/app_router.dart';

import 'common_libs.dart';
import 'logic/language/language_cubit.dart';
import 'logic/translation_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlertCubit>(create: (context) => getIt<AlertCubit>()),
        BlocProvider<LanguageCubit>(create: (context) => getIt<LanguageCubit>()),
        BlocProvider<TranslationCubit>(create: (context) => getIt<TranslationCubit>()),
      ],
      child: const OnTheMoveApp(),
    );
  }
}

class OnTheMoveApp extends StatefulWidget {
  const OnTheMoveApp({Key? key}) : super(key: key);

  @override
  _OnTheMoveAppState createState() => _OnTheMoveAppState();
}

class _OnTheMoveAppState extends State<OnTheMoveApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // LanguageCubit.get(context).getLanguages().listen((_) {});
    // AppTheme.setStatusBarAndNavigationBarColors(ThemeMode.light);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Sizer(builder: (context, constraints, orientation) {
              return MaterialApp(
                // builder: DevicePreview.appBuilder,
                title: 'Nfc Demo',
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode: ThemeMode.light,
                builder: (context, child) {
                  return ResponsiveWrapper.builder(
                      BouncingScrollWrapper.builder(context, child!),
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: 450,
                      defaultScale: true,
                      breakpoints: [
                      const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                  ],
                  background: Container(color: const Color(0xFFF5F5F5)));
                  // return child!;
                },
                // navigatorKey: alice.getNavigatorKey(),
                // debugShowCheckedModeBanner: false,
                initialRoute: '/',
                // initialRoute: AppRouter.main,
                routes: {
                  '/': (context) => const MainScreen(),
                  '/readTag': (context) => const ReadTagScreen(),
                },
                // home: const MainScreen(),
                onGenerateRoute: AppRouter.onGenerateRoute,
                scrollBehavior: AppCustomScrollBehavior(),
              );
            });
          },
        );
      },
    );
  }
}

class AppCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
