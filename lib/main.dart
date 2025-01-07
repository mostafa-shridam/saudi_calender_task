import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:saudi_calender_task/core/services/app_theme.dart';

import 'core/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        useOnlyLangCode: true,
        useFallbackTranslations: true,
        startLocale: Locale("ar"),
        fallbackLocale: Locale("ar"),
        supportedLocales: [
          Locale('ar'),
          Locale('en'),
        ],
        path: 'assets/translations',
        child: SaudiCalenderApp(),
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
}

class SaudiCalenderApp extends ConsumerWidget {
  const SaudiCalenderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveBreakpoints(
      breakpoints: const [
        Breakpoint(start: 0, end: 600, name: MOBILE),
        Breakpoint(start: 601, end: 1200, name: TABLET),
        Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: appTheme("IBMPlexSansArabic"),
        routerConfig: Routes.instance.getRoutes(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          return ResponsiveScaledBox(
            width: ResponsiveValue<double?>(
              context,
              conditionalValues: [
                const Condition.equals(name: MOBILE, value: 450),
                const Condition.between(start: 601, end: 800, value: 800),
                Condition.between(
                  start: 801,
                  end: 1200,
                  value: mediaQueryData.size.width,
                ),
                Condition.largerThan(
                  name: TABLET,
                  value: mediaQueryData.size.width,
                ),
              ],
            ).value,
            child: MediaQuery(
              data: mediaQueryData.copyWith(
                textScaler: TextScaler.linear(1),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
