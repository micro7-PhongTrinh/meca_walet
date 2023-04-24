import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/connectivity/connectivity_bloc.dart';

import 'widgets/featured_membership_card.dart';
import 'widgets/featured_product.dart';
import 'widgets/recommended_store.dart';

class MWHome extends StatelessWidget {
  const MWHome({
    Key? key,
  }) : super(key: key);

  static String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
            child: const _IDHomeView()));
  }
}

class _IDHomeView extends StatelessWidget {
  const _IDHomeView();

  // import category from outside make testable
  final List<String> categories = const [
    'Quần áo',
    'Coffee',
    'Nhà hàng',
    'Mua sắm',
    'Ăn vặt',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 64),
        child: Column(children: [
          const SizedBox(height: 64),
          const FeaturedMembershipCard(),
          const SizedBox(height: 64),
          FeaturedProduct(categories: categories),
          const SizedBox(height: 64),
          const RecommendedStore(),
        ]));
  }
}
