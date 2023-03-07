import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/connectivity/connectivity_bloc.dart';
import 'package:meca_wallet/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/landing/landing_screen.dart';
import 'firebase_options.dart';
import 'utils/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) =>
            ConnectivityBloc()..add(ConnectedConnectivityEvent()),
      )
    ],
    child: LayoutBuilder(builder: (context, constraints) {
      final customTheme = CustomTheme(constraints);
      return MaterialApp(
          title: 'Series 2 Ecommerce',
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
            textButtonTheme: customTheme.textButtonTheme(),
            dividerTheme: customTheme.dividerTheme(),
          ),
          home: const LandingScreen(),
          routes: routes);
    }),
  ));
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
