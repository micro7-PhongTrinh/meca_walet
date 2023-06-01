import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/store/bloc/get_event_cubit.dart';
import 'package:meca_wallet/features/store/widgets/happening_event.dart';
import 'package:meca_wallet/model/event_card.dart';
import 'package:meca_wallet/widgets/event_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../widget_test_extention.dart';
import 'store_event_test.mocks.dart';

@GenerateMocks(<Type>[GetEventCubit])
main() {
  MockGetEventCubit mockCubit = MockGetEventCubit();

  List<EventCardModel> mockData = [
    EventCardModel(
        'Chương trình tích thẻ thành viên với Meca',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTshVuqsxo_De8yDZK8a7PrtEHizBQlqhP-FEIk6vAWaA&s',
        DateTime(2023, 5, 5),
        DateTime(2023, 5, 23)),
    EventCardModel(
        'Mua hàng lần đầu tại Cheese Coffee',
        'https://images.foody.vn/res/g66/652833/prof/s1242x600/image-0f237865-221019091025.jpeg',
        DateTime(2023, 5, 5),
        DateTime(2023, 5, 23))
  ];

  setUp(() async {
    when(mockCubit.state).thenAnswer((_) => GetEventInitial());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream<GetEventState>.value(GetEventInitial()));
  });

  testWidgets('Event can get event cubit from widget above',
      (widgetTester) async {
    Widget widget = const HappeningEvents();

    await widgetTester.blocWrapAndPump<GetEventCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester
            .widget(find.byType(BlocBuilder<GetEventCubit, GetEventState>)),
        isA<BlocBuilder<GetEventCubit, GetEventState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
  });
  testWidgets('Verify UI store event widget', (widgetTester) async {
    Widget widget = const HappeningEvents();

    await widgetTester.blocWrapAndPump<GetEventCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.text('Sự kiện đang diễn ra'), findsOneWidget);
    expect(find.byType(ListEvent), findsOneWidget);
  });
  testWidgets('Verify store widget will call get event from cubit',
      (widgetTester) async {
    Widget widget = const HappeningEvents();

    await widgetTester.blocWrapAndPump<GetEventCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    verify(mockCubit.getStoreEvent(any)).called(1);
  });
  testWidgets('When get event succees, expect find event on screen',
      (widgetTester) async {
    when(mockCubit.state).thenAnswer((_) => GetEventSuccess(mockData));
    when(mockCubit.stream).thenAnswer(
        (_) => Stream<GetEventState>.value(GetEventSuccess(mockData)));

    Widget widget = const HappeningEvents();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetEventCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(EventCard), findsNWidgets(mockData.length));
  });
}
