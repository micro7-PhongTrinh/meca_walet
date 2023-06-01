import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/overview_membership_card/bloc/get_current_activity_cubit.dart';
import 'package:meca_wallet/features/overview_membership_card/widgets/list_recent_activity.dart';
import 'package:meca_wallet/model/card_activity.dart';
import 'package:meca_wallet/widgets/error/recent_activity_error.dart';
import 'package:meca_wallet/widgets/skeleton/recent_activity_skeleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../widget_test_extention.dart';
import '../membership_card_screen_test.mocks.dart';

@GenerateMocks(<Type>[GetCurrentActivityCubit])
main() {
  final MockGetCurrentActivityCubit mockGetCurrentActivityCubit =
      MockGetCurrentActivityCubit();
  final List<CardActivityModel> activities = [
    CardActivityModel(
        'Jollibee',
        'https://www.clipartmax.com/png/middle/133-1332451_jollibee-clipart-classic-jollibee-fast-food-logo.png',
        'Mua hàng thành công',
        2),
    CardActivityModel(
        'Mini Stop',
        'https://cdn.freebiesupply.com/logos/large/2x/mini-stop-logo-png-transparent.png',
        'Mở thẻ thành viên',
        1),
    CardActivityModel(
        'Circle K',
        'https://e7.pngegg.com/pngimages/157/520/png-clipart-circle-k-retail-convenience-shop-business-franchising-business-text-rectangle-thumbnail.png',
        'Mua hàng thành công',
        1),
    CardActivityModel(
        'Starbucks',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcLgB_TDiHpxjkxG0_JEKLO7kddGqo-XrzgQ&usqp=CAU',
        'Mua hàng thành công',
        1),
    CardActivityModel(
        'Jollibee',
        'https://www.clipartmax.com/png/middle/133-1332451_jollibee-clipart-classic-jollibee-fast-food-logo.png',
        'Mở thẻ thành viên',
        1),
  ];

  setUp(() async {
    when(mockGetCurrentActivityCubit.state)
        .thenAnswer((_) => GetCurrentActivityInitial());
    when(mockGetCurrentActivityCubit.stream).thenAnswer((_) =>
        Stream<GetCurrentActivityState>.value(GetCurrentActivityInitial()));
  });

  tearDown(() {
    reset(mockGetCurrentActivityCubit);
  });

  testWidgets('Verify recent activity widget can get cubit from above',
      (widgetTester) async {
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetCurrentActivityCubit, GetCurrentActivityState>)),
        isA<BlocBuilder<GetCurrentActivityCubit, GetCurrentActivityState>>()
            .having((t) => t.bloc, 'is mockGetCurrentActivityCubit?',
                mockGetCurrentActivityCubit));
  });
  testWidgets(
      'Verify recent activity widget call getActivity method from above cubit',
      (widgetTester) async {
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    verify(mockGetCurrentActivityCubit.getLatelyActivities()).called(1);
  });
  testWidgets('Verify UI show recent activities ', (widgetTester) async {
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.text('Hoạt động gần đây'), findsOneWidget);
    expect(find.byType(ListRecentActivity), findsOneWidget);
  });
  testWidgets('When state is initial, expect to find list activity skeleton',
      (widgetTester) async {
    //state from set up
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(RecentActivitySkeleton), findsWidgets);
  });
  testWidgets('When state is loading, expect to find list activity skeleton',
      (widgetTester) async {
    when(mockGetCurrentActivityCubit.state)
        .thenAnswer((_) => GetCurrentActivityLoading());
    when(mockGetCurrentActivityCubit.stream).thenAnswer((_) =>
        Stream<GetCurrentActivityState>.value(GetCurrentActivityLoading()));
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(RecentActivitySkeleton), findsWidgets);
  });
  testWidgets('When state is load success, expect to find list item activity',
      (widgetTester) async {
    when(mockGetCurrentActivityCubit.state)
        .thenAnswer((_) => GetCurrentActivitySuccess(activities));
    when(mockGetCurrentActivityCubit.stream).thenAnswer((_) =>
        Stream<GetCurrentActivityState>.value(
            GetCurrentActivitySuccess(activities)));
    Widget widget = const ListRecentActivity();
    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
          mockGetCurrentActivityCubit, widget);
      await widgetTester.pumpAndSettle();

      expect(find.byType(RecentActivity), findsNWidgets(activities.length));
    });
  });
  testWidgets(
      'When state is load fail, expect to find load activity error widget',
      (widgetTester) async {
    when(mockGetCurrentActivityCubit.state)
        .thenAnswer((_) => GetCurrentActivityFail());
    when(mockGetCurrentActivityCubit.stream).thenAnswer(
        (_) => Stream<GetCurrentActivityState>.value(GetCurrentActivityFail()));
    Widget widget = const ListRecentActivity();

    await widgetTester.blocWrapAndPump<GetCurrentActivityCubit>(
        mockGetCurrentActivityCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(RecentActivityError), findsOneWidget);
  });
}
