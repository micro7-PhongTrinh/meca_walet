import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => GetStoreInforCubit()),
      BlocProvider<GetMemcardCubit>(create: (context) => GetMemcardCubit()),
      BlocProvider<GetEventCubit>(create: (context) => GetEventCubit()),
      BlocProvider<GetProductCubit>(create: (context) => GetProductCubit())
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
    BlocProvider.of<GetStoreInforCubit>(context).getStoreInfor('123');
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
              StorescreenBody(
                  title: state.store.name, logoUrl: state.store.logoUrl)
            ],
          );
        }
        return Container();
      }),
    );
  }
}

class StorescreenBody extends StatelessWidget {
  const StorescreenBody({
    super.key,
    required this.title,
    required this.logoUrl,
  });
  final String title;
  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          StoreRepresentInfor(title: title, logoUrl: logoUrl),
          const MembershipIntegrateCard(),
          const HappeningEvents(),
          const StoreProducts(),
          const SizedBox(
            height: 1200,
          )
        ]),
      ),
    );
  }
}
