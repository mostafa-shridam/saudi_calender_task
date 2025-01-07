import 'package:go_router/go_router.dart';

import 'mobile/mobile_router.dart';

class Routes {
  Routes._internal();

  static final instance = Routes._internal();
  static Routes get initial => instance;
  GoRouter? _router;

  GoRouter getRoutes() {
    return _router != null ? _router! : _router = MobileRoutes().getRoutes();
  }
}
