import 'package:application_state/application_state.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/application_setting/application_setting_bloc.dart';
import 'package:meca_wallet/bloc/authentication/authentication/authentication_bloc.dart';
import 'package:meca_wallet/bloc/connectivity/connectivity_bloc.dart';
import 'package:meca_wallet/features/home/home_screen.dart';
import 'package:meca_wallet/firebase_options.dart';
import 'package:meca_wallet/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meca_wallet/utils/custom_theme.dart';

import 'features/login/login_screen.dart';
import 'features/store/store_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var applicationState = await ApplicationState.createInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(RepositoryProvider(
      create: (_) => AuthenticationService(),
      child: MultiBlocProvider(providers: [
        BlocProvider<ConnectivityBloc>(
          create: (BuildContext context) =>
              ConnectivityBloc()..add(ConnectedConnectivityEvent()),
        ),
        BlocProvider<ApplicationSettingBloc>(
            create: (BuildContext context) =>
                ApplicationSettingBloc(applicationState)
                  ..add(CheckUserLoggedinEvent())),
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                authenticationService: context.read<AuthenticationService>()))
      ], child: const AppView())));
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final customTheme = CustomTheme(constraints);
      return MaterialApp(
          routes: routes,
          title: 'Meca Wallet',
          theme: ThemeData(
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
            textButtonTheme: customTheme.textButtonTheme(),
            dividerTheme: customTheme.dividerTheme(),
          ),
          //test
          //home: const LandingScreen(),
          home: const LoginScreen());
    });
  }
}

class ScreenUnavailable extends StatelessWidget {
  const ScreenUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Screen unavailable'),
        ),
        body: const Center(
          child: Text(
              'Sorry, this screen is still under construction. Please come back later.'),
        ),
      );
}
