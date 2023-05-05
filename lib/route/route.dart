import 'package:flutter/material.dart';
import 'package:meca_wallet/features/connectivity/no_connection_screen.dart';
import 'package:meca_wallet/features/detail_memberhsip_card/detail_membership_card_screen.dart';
import 'package:meca_wallet/features/home/home_screen.dart';
import 'package:meca_wallet/features/store/store_screen.dart';

import '../features/landing/intro_screen.dart';
import '../features/landing/landing_screen.dart';
import '../features/login/login_screen.dart';
import '../features/overview_membership_card/overview_membership_card_screen.dart';

export 'package:go_router/go_router.dart';

const String noConnectionRoute = '/noConnection';
const String landingRoute = '/landing';

Map<String, Widget Function(BuildContext)> routes = {
  MWHome.routeName: (ctx) => const MWHome(),
  noConnectionRoute: (ctx) => const NoConnectionScreen(),
  landingRoute: (ctx) => const LandingScreen(),
  IntroScreen.routeName: (ctx) => const IntroScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  StoreScreen.routeName: (ctx) => StoreScreen(),
  OverviewMembershipCardScreen.routeName: (ctx) =>
      const OverviewMembershipCardScreen(),
  DetailMembershipCardScreen.routeName: (ctx) =>
      const DetailMembershipCardScreen()
};
