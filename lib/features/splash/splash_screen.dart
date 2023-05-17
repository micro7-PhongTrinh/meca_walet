import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/login/login_screen.dart';

import '../../bloc/authentication/authentication/authentication_bloc.dart';
import '../../bloc/connectivity/connectivity_bloc.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String routeName = '/splashScreen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        // ignore: always_specify_types
        listeners: [
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (BuildContext context, ConnectivityState state) {
              WidgetsBinding.instance
                  .addPostFrameCallback((Duration timeStamp) {
                debugPrint('change connection');
                context
                    .read<ConnectivityBloc>()
                    .add(ChangeConnectConnectivityEvent());
              });
              if (state is ChangeConnectedState) {
                debugPrint('change to connect');
                Navigator.of(context).pop();
              }
              if (state is ChangeDisonnectedState) {
                debugPrint('change to Disconnect');
                Navigator.of(context).pushNamed('/noConnection');
              }
              if (state is ConnectedState) {
                debugPrint('connected');
              }
              if (state is DisconnectedState) {
                debugPrint('disconnected');
                Navigator.of(context).pushNamed('/noConnection');
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticatedState) {
                print('loged in!');
                Navigator.of(context).pushNamed(MWHome.routeName);
              }
              if (state is UnauthenticatedState) {
                print('not logged in..');
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }
            },
          )
        ],
        child: const SplashScreenBody());
  }
}

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
