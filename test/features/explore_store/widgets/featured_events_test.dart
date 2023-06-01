import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_featured_events_cubit.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_events.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item_skeleton.dart';
import 'package:meca_wallet/model/event_model.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_test_extention.dart';
import '../explore_store_screen_test.mocks.dart';

void main() {
  MockGetFeaturedEventsCubit mockGetFeaturedEventsCubit =
      MockGetFeaturedEventsCubit();

  List<EventModel> mockData = List.generate(
      4,
      (index) => EventModel(
          'Chương trình tích thẻ thành viên với Meca',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTshVuqsxo_De8yDZK8a7PrtEHizBQlqhP-FEIk6vAWaA&s',
          DateTime(2023, 5, 5),
          DateTime(2023, 5, 23),
          '123'));

  setUp(() async {
    when(mockGetFeaturedEventsCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedEventsInitial());
    when(mockGetFeaturedEventsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedEventsState>.value(GetFeaturedEventsInitial()));
  });

  tearDown(() async {
    reset(mockGetFeaturedEventsCubit);
  });

  testWidgets('Verify featured events UI', (widgetTester) async {
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(find.text('Sự kiện đang diễn ra'), findsOneWidget);
    expect(find.byType(FeaturedEventItems), findsOneWidget);
  });
  testWidgets('Verify featred events will get cubit from above widget',
      (widgetTester) async {
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetFeaturedEventsCubit, GetFeaturedEventsState>)),
        isA<BlocBuilder<GetFeaturedEventsCubit, GetFeaturedEventsState>>()
            .having(
                (t) => t.bloc, 'is mockCubit?', mockGetFeaturedEventsCubit));
  });
  testWidgets('When state is initial, expect list skeleton appear',
      (widgetTester) async {
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
  testWidgets('When state is success, expect list featured event appear',
      (widgetTester) async {
    when(mockGetFeaturedEventsCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedEventsSuccess(mockData));
    when(mockGetFeaturedEventsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedEventsState>.value(
            GetFeaturedEventsSuccess(mockData)));
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(find.byType(FeaturedItem), findsNWidgets(mockData.length));
  });
  testWidgets('Whenn state is loading, expect list skeleton appear',
      (widgetTester) async {
    when(mockGetFeaturedEventsCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedEventsLoading());
    when(mockGetFeaturedEventsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedEventsState>.value(GetFeaturedEventsLoading()));
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
  testWidgets('When state is load fail, expect list skeleton appear',
      (widgetTester) async {
    when(mockGetFeaturedEventsCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedEventsFail());
    when(mockGetFeaturedEventsCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedEventsState>.value(GetFeaturedEventsFail()));
    Widget widget = const FeaturedEvents();

    await widgetTester.blocWrapAndPump<GetFeaturedEventsCubit>(
        mockGetFeaturedEventsCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
}
