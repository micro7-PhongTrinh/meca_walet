import 'package:flutter/material.dart';
import 'package:meca_wallet/features/connectivity/no_connection_screen.dart';
import 'package:meca_wallet/features/home/home_screen.dart';

import '../features/landing/intro_screen.dart';
import '../features/landing/landing_screen.dart';
import '../features/login/login_screen.dart';

export 'package:go_router/go_router.dart';

const String noConnectionRoute = '/noConnection';
const String landingRoute = '/landing';

Map<String, Widget Function(BuildContext)> routes = {
  IDHome.routeName: (ctx) => const IDHome(),
  noConnectionRoute: (ctx) => const NoConnectionScreen(),
  landingRoute: (ctx) => const LandingScreen(),
  IntroScreen.routeName: (ctx) => const IntroScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen()
};
