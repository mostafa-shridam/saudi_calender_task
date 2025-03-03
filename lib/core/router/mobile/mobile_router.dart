import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/ui/pages/add_event/add_event_page.dart';
import 'package:saudi_calender_task/ui/pages/auth/sign_in_page.dart';
import 'package:saudi_calender_task/ui/pages/details/details_page.dart';
import 'package:saudi_calender_task/ui/pages/my_event_details/my_event_details.dart';

import '../../../models/event_model.dart';
import '../../../ui/pages/main/main_page.dart';
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
          builder: (context, state) {
            final EventModel eventModel = state.extra as EventModel;
            return DetailsPage(
              event: eventModel,
            );
          },
        ),
        GoRoute(
          path: AddEditEventPage.routeName,
          name: AddEditEventPage.routeName,
          builder: (context, state) {
            final MyEvent? myEvent = state.extra as MyEvent?;
            if (myEvent == null) {
              return const AddEditEventPage();
            } else {
              return AddEditEventPage(
                myEvent: myEvent,
              );
            }
          },
        ),
        GoRoute(
          path: MyEventDetails.routeName,
          name: MyEventDetails.routeName,
          builder: (context, state) {
            final MyEvent myEvent = state.extra as MyEvent;
            return MyEventDetails(
              myEvent: myEvent,
            );
          },
        ),
        GoRoute(
          path: SignInPage.routeName,
          name: SignInPage.routeName,
          builder: (context, state) => const SignInPage(),
        ),
      ],
      observers: observers,
    );
  }
}
