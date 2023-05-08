import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/presentation/screens/main/main_screen.dart';

class AppRouter {
  static const String main = 'main';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
