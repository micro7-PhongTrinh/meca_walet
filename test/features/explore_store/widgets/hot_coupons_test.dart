import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_hot_coupons_cubit.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item_skeleton.dart';
import 'package:meca_wallet/features/explore_store/widgets/hot_coupons.dart';
import 'package:meca_wallet/model/coupon_model.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_test_extention.dart';
import '../explore_store_screen_test.mocks.dart';

void main() {
  MockGetHotCoupounsCubit mockCubit = MockGetHotCoupounsCubit();

  List<CoupounModel> mockData = List.generate(
      4,
      (index) => CoupounModel('Giảm 5% khi mua thức uống tại cửa hàng', '123',
          'https://t.pimg.jp/050/711/330/1/50711330.jpg'));

  setUp(() async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetHotCoupounsInitial());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetHotCoupounsState>.value(GetHotCoupounsInitial()));
  });

  tearDown(() async {
    reset(mockCubit);
  });

  testWidgets('Verify hot coupons UI', (widgetTester) async {
    Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(find.text('Ưu đãi hấp dẫn'), findsOneWidget);
    expect(find.byType(HotCouponItems), findsOneWidget);
  });
  testWidgets('Verify hot coupons will get cubit from above widget',
      (widgetTester) async {
        Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetHotCoupounsCubit, GetHotCoupounsState>)),
        isA<BlocBuilder<GetHotCoupounsCubit, GetHotCoupounsState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
      });
  testWidgets('When state is initial, expect list skeleton appear',
      (widgetTester) async {
        Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
      });
  testWidgets('When state is success, expect list hot coupon appear',
      (widgetTester) async {
        when(mockCubit.state)
        .thenAnswer((realInvocation) => GetHotCoupounsSuccess(mockData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetHotCoupounsState>.value(
            GetHotCoupounsSuccess(mockData)));

    Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItem), findsNWidgets(mockData.length));
      });
  testWidgets('Whenn state is loading, expect list skeleton appear',
      (widgetTester) async {
        when(mockCubit.state)
        .thenAnswer((realInvocation) => GetHotCoupounsLoading());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetHotCoupounsState>.value(GetHotCoupounsLoading()));

    Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
      });
  testWidgets('When state is load fail, expect list skeleton appear',
      (widgetTester) async {
         when(mockCubit.state)
        .thenAnswer((realInvocation) => GetHotCoupounsFail());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetHotCoupounsState>.value(GetHotCoupounsFail()));

    Widget widget = const HotCoupons();

    await widgetTester.blocWrapAndPump<GetHotCoupounsCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
      });
}
