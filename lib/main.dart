import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/connectivity/connectivity_bloc.dart';
import 'package:meca_wallet/route/route.dart';

void main() async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) => ConnectivityBloc(),
      )
    ],
    child: MaterialApp.router(
      routerConfig: appRoute,
      title: 'Interactive Diary',
      builder: (context, child) {
        if (child != null) {
          final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
              child: child);
        }

        // return unavailable screen
        return const ScreenUnavailable();
      },
    ),
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
          child: Text('Sorry, this screen is still under construction. Please come back later.'),
        ),
      );
}
