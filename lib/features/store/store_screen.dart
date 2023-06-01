import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/store.dart';
import 'package:meca_service/meca_service.dart';

import 'bloc/get_event_cubit.dart';
import 'bloc/get_memcard_cubit.dart';
import 'bloc/get_product_cubit.dart';
import 'bloc/get_store_infor_cubit.dart';
import 'widgets/happening_event.dart';
import 'widgets/membership_integrate_card.dart';
import 'widgets/store_appbar.dart';
import 'widgets/store_products.dart';
import 'widgets/store_represent_infor.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static String routeName = '/storeScreen';

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    final MecaService mecaService = RepositoryProvider.of<MecaService>(context);
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              GetStoreInforCubit(mecaService: mecaService, id: id.toString())),
      BlocProvider<GetMemcardCubit>(
          create: (context) => GetMemcardCubit(mecaService: mecaService)),
      BlocProvider<GetEventCubit>(
          create: (context) => GetEventCubit(mecaService: mecaService)),
      BlocProvider<GetProductCubit>(
          create: (context) => GetProductCubit(mecaService: mecaService))
    ], child: StoreScreenView());
  }
}

class StoreScreenView extends StatefulWidget {
  StoreScreenView({super.key});

  final _scrollController = ScrollController();
  @override
  State<StoreScreenView> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreenView> {
  bool _isSliverAppBarExpanded = false;

  @override
  void initState() {
    BlocProvider.of<GetStoreInforCubit>(context).getStoreInfor();
    widget._scrollController.addListener(() {
      setState(() {
        _isSliverAppBarExpanded = widget._scrollController.hasClients &&
            widget._scrollController.offset >
                (MediaQuery.of(context).size.height * 0.36);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetStoreInforCubit, GetStoreInforState>(
          builder: (context, state) {
        if (state is GetStoreInforSuccess) {
          return CustomScrollView(
            controller: widget._scrollController,
            slivers: [
              StoreScreenAppBar(
                  isSliverAppBarExpanded: _isSliverAppBarExpanded,
                  title: state.store.name,
                  imgUrls: state.store.imgUrl),
              StorescreenBody(store: state.store)
            ],
          );
        }
        return Container();
      }),
    );
  }
}

class StoreValue extends InheritedWidget {
  const StoreValue({super.key, required this.store, required super.child});

  final Store store;

  static StoreValue? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoreValue>();
  }

  static StoreValue of(BuildContext context) {
    final StoreValue? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StoreValue oldWidget) => store != oldWidget.store;
}

class StorescreenBody extends StatelessWidget {
  const StorescreenBody({
    super.key,
    required this.store,
  });
  final Store store;

  @override
  Widget build(BuildContext context) {
    return StoreValue(
      store: store,
      child: SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            const Column(
              children: [
                StoreRepresentInfor(),
                MembershipIntegrateCard(),
                HappeningEvents(),
                StoreProducts(),
                SizedBox(
                  height: 1200,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
