import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/route/route.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget) async {
    final wraper = _MaterialWrapWidget(child: widget);

    await pumpWidget(wraper);

    await pumpFrames(wraper, const Duration(milliseconds: 16));
  }

  Future<void> blocWrapAndPump<B extends StateStreamableSource<Object?>>(
      B bloc, Widget widget,
      {bool infiniteAnimationWidget = false,
      bool useRouter = false,
      String? targetRoute}) async {
    final Widget wrapper = BlocProvider<B>(
        create: (_) => bloc,
        child: _MaterialWrapWidget(
            useRouter: useRouter, targetRoute: targetRoute, child: widget));

    await pumpWidget(wrapper);

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }
}

class _MaterialWrapWidget extends StatelessWidget {
  final Widget child;
  final bool useRouter;
  final String? targetRoute;

  const _MaterialWrapWidget(
      {required this.child, this.useRouter = false, this.targetRoute, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useRouter
        ? MaterialApp(routes: routes, home: Scaffold(body: child))
        : MaterialApp(
            home: Scaffold(
              body: child,
            ),
          );
  }
}
