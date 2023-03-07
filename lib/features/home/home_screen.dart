import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/connectivity/connectivity_bloc.dart';
import 'package:meca_wallet/route/route.dart';

class IDHome extends StatelessWidget {
  const IDHome({
    Key? key,
  }) : super(key: key);

  static String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) => Scaffold(
          body: MultiBlocListener(
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
                  context.pop();
                }
                if (state is ChangeDisonnectedState) {
                  debugPrint('change to Disconnect');
                  context.push('/noConnection');
                }
                if (state is ConnectedState) {
                  debugPrint('connected');
                }
                if (state is DisconnectedState) {
                  debugPrint('disconnected');
                  context.push('/noConnection');
                }
              },
            ),
          ],
              child: Container(color: Colors.red)));
}
