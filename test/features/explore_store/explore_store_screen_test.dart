import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_stores_cubit.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_featured_events_cubit.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_hot_coupons_cubit.dart';
import 'package:meca_wallet/features/explore_store/explore_store_screen.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_events.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_stores.dart';
import 'package:meca_wallet/features/explore_store/widgets/hot_coupons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../widget_test_extention.dart';
import 'explore_store_screen_test.mocks.dart';

@GenerateMocks(
    <Type>[GetFeaturedStoresCubit, GetFeaturedEventsCubit, GetHotCoupounsCubit])
void main() {
  MockGetFeaturedEventsCubit mockGetFeaturedEventsCubit =
      MockGetFeaturedEventsCubit();
  MockGetFeaturedStoresCubit mockGetFeaturedStoresCubit =
      MockGetFeaturedStoresCubit();
  MockGetHotCoupounsCubit mockGetHotCoupounsCubit = MockGetHotCoupounsCubit();

  testWidgets('Modify UI explore store screen', (widgetTester) async {
    Widget widget = const ExploreStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Khám phá'), findsOneWidget);
    expect(find.text('Cửa hàng trên Meca'), findsOneWidget);
    expect(find.byType(FilteredOptions), findsOneWidget);
    expect(find.byType(FeaturedStores), findsOneWidget);
    expect(find.byType(FeaturedEvents), findsOneWidget);
    expect(find.byType(HotCoupons), findsOneWidget);
  });
  testWidgets('Verify store screen include get fearuted store cubit',
      (widgetTester) async {
    Widget widget = const ExploreStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(BlocProvider<GetFeaturedStoresCubit>), findsOneWidget);
  });
  testWidgets('Verify store screen include get happening event cubit',
      (widgetTester) async {
    Widget widget = const ExploreStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(BlocProvider<GetFeaturedEventsCubit>), findsOneWidget);
  });
  testWidgets('Verify explore store screen include get hot coupon cubit',
      (widgetTester) async {
    Widget widget = const ExploreStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(BlocProvider<GetHotCoupounsCubit>), findsOneWidget);
  });
  testWidgets('Verify call to get method cubit when change filtered option',
      (widgetTester) async {
    when(mockGetFeaturedEventsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedEventsState>.value(GetFeaturedEventsInitial()));
    when(mockGetFeaturedStoresCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedStoresState>.value(GetFeaturedStoresInitial()));
    when(mockGetHotCoupounsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetHotCoupounsState>.value(GetHotCoupounsInitial()));

    Widget widget = const FilteredOptions(filteredOptions: ['kkk']);

    await mockNetworkImages(() async {
      await widgetTester
          .multiBlocWrapAndPump(<BlocProvider<StateStreamableSource<Object?>>>[
        BlocProvider<GetHotCoupounsCubit>(
            create: (_) => mockGetHotCoupounsCubit),
        BlocProvider<GetFeaturedEventsCubit>(
            create: (_) => mockGetFeaturedEventsCubit),
        BlocProvider<GetFeaturedStoresCubit>(
            create: (_) => mockGetFeaturedStoresCubit)
      ], widget);

      await widgetTester.tap(find.descendant(
          of: find.byKey(const ValueKey('filterd_option_tab_0')),
          matching: find.byType(TextButton)));

      await widgetTester.pumpAndSettle();

      verify(mockGetHotCoupounsCubit.getHotCoupouns()).called(1);
      verify(mockGetFeaturedStoresCubit.getFeaturedStores()).called(1);
      verify(mockGetFeaturedEventsCubit.getFeaturedEvents()).called(1);
    });
  });
}
