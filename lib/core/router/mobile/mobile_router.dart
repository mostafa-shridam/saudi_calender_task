import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/pages/details/details_page.dart';

import '../../../pages/main/main_page.dart';
import '../routing_base.dart';

class MobileRoutes extends RoutingBase {
  @override
  GoRouter getRoutes({
    List<NavigatorObserver>? observers,
    String? initialLocation,
  }) {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: initialLocation ?? MainPage.routeName,
      redirect: (context, state) {
        if (state.uri.toString().contains('dlink') == true) {
          return MainPage.routeName;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: MainPage.routeName,
          name: MainPage.routeName,
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: DetailsPage.routeName,
          name: DetailsPage.routeName,
          builder: (context, state) => const DetailsPage(),
        ),
      ],
      observers: observers,
    );
  }
}