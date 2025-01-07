import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class RoutingBase {
  GoRouter getRoutes({
    List<NavigatorObserver>? observers,
    String? initialLocation,
  });
}
