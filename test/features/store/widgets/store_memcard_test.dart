import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/store/bloc/get_memcard_cubit.dart';
import 'package:meca_wallet/features/store/widgets/membership_integrate_card.dart';
import 'package:meca_wallet/model/membership_card.dart';
import 'package:meca_wallet/widgets/membership_store_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../widget_test_extention.dart';
import 'store_memcard_test.mocks.dart';

@GenerateMocks(<Type>[GetMemcardCubit])
main() {
  MockGetMemcardCubit mockCubit = MockGetMemcardCubit();

  MembershipCardModel mockData = MembershipCardModel('Cheese Coffee',
      'assets/images/jollibee_logo.png', 'Phong Trinh', 21, 3, cardColors[0]);

  setUp(() async {
    when(mockCubit.state).thenAnswer((_) => GetMemcardInitial());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream<GetMemcardState>.value(GetMemcardInitial()));
  });

  testWidgets('Memcard can get memcard cubit from widget above',
      (widgetTester) async {
    Widget widget = const MembershipIntegrateCard();

    await widgetTester.blocWrapAndPump<GetMemcardCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester
            .widget(find.byType(BlocBuilder<GetMemcardCubit, GetMemcardState>)),
        isA<BlocBuilder<GetMemcardCubit, GetMemcardState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
  });
  testWidgets('Verify UI store memcard widget', (widgetTester) async {
    Widget widget = const MembershipIntegrateCard();

    await widgetTester.blocWrapAndPump<GetMemcardCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.text('Thẻ thành viên'), findsOneWidget);
    expect(find.byType(MembershipStoreBody), findsOneWidget);
  });
  testWidgets('Verify store widget will call get memcard from cubit',
      (widgetTester) async {
    Widget widget = const MembershipIntegrateCard();

    await widgetTester.blocWrapAndPump<GetMemcardCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    verify(mockCubit.getStoreMemcard(any)).called(1);
  });
  testWidgets('When get event succees, expect find memcard on screen',
      (widgetTester) async {
    when(mockCubit.state).thenAnswer((_) => GetMemcardSuccess(mockData));
    when(mockCubit.stream).thenAnswer(
        (_) => Stream<GetMemcardState>.value(GetMemcardSuccess(mockData)));

    Widget widget = const MembershipIntegrateCard();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetMemcardCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(MembershipStoreCard), findsOneWidget);
  });
}
