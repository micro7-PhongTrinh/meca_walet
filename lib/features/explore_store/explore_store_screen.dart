import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';

import '../../bloc/common_cubit/get_featured_stores_cubit.dart';
import '../../widgets/selected_text_button.dart';
import 'bloc/get_featured_events_cubit.dart';
import 'bloc/get_hot_coupons_cubit.dart';
import 'widgets/explore_store_appbar.dart';
import 'widgets/featured_events.dart';
import 'widgets/featured_stores.dart';
import 'widgets/hot_coupons.dart';

class ExploreStoreScreen extends StatelessWidget {
  const ExploreStoreScreen({super.key});

  static String routeName = '/exploreStoreScreen';

  final List<String> filteredOptions = const [
    'Tất cả',
    'Thịnh hành',
    'Món ăn',
    'Dịch vụ'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetFeaturedStoresCubit>(
              create: (_) => GetFeaturedStoresCubit(mecaService:  RepositoryProvider.of<MecaService>(context))),
          BlocProvider<GetFeaturedEventsCubit>(
              create: (_) => GetFeaturedEventsCubit()),
          BlocProvider<GetHotCoupounsCubit>(
              create: (_) => GetHotCoupounsCubit())
        ],
        child: ExploreStoreBody(filteredOptions: filteredOptions),
      ),
    );
  }
}

class ExploreStoreBody extends StatelessWidget {
  const ExploreStoreBody({
    super.key,
    required this.filteredOptions,
  });

  final List<String> filteredOptions;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[const ExploreStoreAppbar()];
        },
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          children: [
            Column(children: [
              FilteredOptions(filteredOptions: filteredOptions),
              const SizedBox(height: 40),
              const FeaturedStores(),
              const SizedBox(height: 20),
              const FeaturedEvents(),
              const SizedBox(height: 20),
              const HotCoupons(),
              const SizedBox(
                height: 1200,
              )
            ]),
          ],
        ));
  }
}

class FilteredOptions extends StatefulWidget {
  const FilteredOptions({
    super.key,
    required this.filteredOptions,
  });

  final List<String> filteredOptions;

  @override
  State<FilteredOptions> createState() => _FilteredOptionsState();
}

class _FilteredOptionsState extends State<FilteredOptions> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('filterd_option_tab'),
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.filteredOptions.length,
            (index) => Container(
                margin: const EdgeInsets.only(right: 8),
                child: SelectedTextButton(
                    key: Key('filterd_option_tab_$index'),
                    widget.filteredOptions[index],
                    selectedIndex == index, () {
                  setState(() {
                    selectedIndex = index;
                  });
                  BlocProvider.of<GetFeaturedEventsCubit>(context)
                      .getFeaturedEvents();
                  BlocProvider.of<GetFeaturedStoresCubit>(context)
                      .getFeaturedStores();
                  BlocProvider.of<GetHotCoupounsCubit>(context)
                      .getHotCoupouns();
                })),
          )),
    );
  }
}
