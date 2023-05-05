import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_memcard_cubit.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/detail_memberhsip_card/detail_membership_card_screen.dart';
import 'package:meca_wallet/features/overview_membership_card/widgets/scrollable_list_card.dart';
import 'package:meca_wallet/model/membership_card.dart';
import 'package:meca_wallet/widgets/error/list_memcard_error.dart';
import 'package:meca_wallet/widgets/skeleton/list_membership_card_skeleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_test_extention.dart';
import '../membership_card_screen_test.mocks.dart';

@GenerateMocks(<Type>[GetFeaturedMemcardCubit])
main() {
  final MockGetFeaturedMemcardCubit mockMemcardCubit =
      MockGetFeaturedMemcardCubit();

  final List<MembershipCardModel> cards = [
    MembershipCardModel('Visa', 'assets/images/visa_logo.png', 'Phong Trinh',
        18, 12, cardColors[0]),
    MembershipCardModel('Jollibee', 'assets/images/jollibee_logo.png',
        'Phong Trinh', 17, 7, cardColors[1]),
    MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
        'Phong Trinh', 23, 9, cardColors[2]),
    MembershipCardModel('Visa', 'assets/images/visa_logo.png', 'Phong Trinh',
        18, 12, cardColors[3]),
    MembershipCardModel('Jollibee', 'assets/images/jollibee_logo.png',
        'Phong Trinh', 17, 7, cardColors[4]),
    MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
        'Phong Trinh', 23, 9, cardColors[1]),
    MembershipCardModel('Visa', 'assets/images/visa_logo.png', 'Phong Trinh',
        18, 12, cardColors[6]),
    MembershipCardModel('Jollibee', 'assets/images/jollibee_logo.png',
        'Phong Trinh', 17, 7, cardColors[5]),
    MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
        'Phong Trinh', 23, 9, cardColors[2])
  ];

  setUp(() async {
    when(mockMemcardCubit.state).thenAnswer((_) => GetFeaturedMemcardInitial());
    when(mockMemcardCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardInitial()));
  });
  tearDown(() {
    reset(mockMemcardCubit);
  });

  testWidgets('Verify memcard list can get provided cubit from above',
      (widgetTester) async {
    Widget widget = const ScrollableListCard();
    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetFeaturedMemcardCubit, GetFeaturedMemcardState>)),
        isA<BlocBuilder<GetFeaturedMemcardCubit, GetFeaturedMemcardState>>()
            .having((t) => t.bloc, 'is mockMemcardCubit?', mockMemcardCubit));
  });
  testWidgets('Verify memcard list call getMemcard from cubit',
      (widgetTester) async {
    Widget widget = const ScrollableListCard();
    widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);

    verify(mockMemcardCubit.getMembershipCardContent()).called(1);
  });
  testWidgets(
      'When state is initial load card, expect to see list card skeleton',
      (widgetTester) async {
    //get state from setup
    Widget widget = const ScrollableListCard();

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);

    expect(find.byType(ListMemcardSkeleton), findsOneWidget);
  });
  testWidgets('When state is loading card, expect too see list card skeleton',
      (widgetTester) async {
    when(mockMemcardCubit.state).thenAnswer((_) => GetFeaturedMemcardLoading());
    when(mockMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardLoading()));
    Widget widget = const ScrollableListCard();

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);

    expect(find.byType(ListMemcardSkeleton), findsOneWidget);
  });
  testWidgets(
      'When state is load success card, expect to see list scroll card ',
      (widgetTester) async {
    when(mockMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardSuccess(cards, cards.length));
    when(mockMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(
            GetFeaturedMemcardSuccess(cards, cards.length)));
    Widget widget = const ScrollableListCard();

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);

    expect(
        widgetTester.widget(find.byType(Swiper)),
        isA<Swiper>().having(
            (t) => t.itemCount,
            'Number of scroll list item match with mock cards length',
            cards.length));
  });
  testWidgets(
      'When state is load fail card, expect to see load list card error',
      (widgetTester) async {
    when(mockMemcardCubit.state).thenAnswer((_) => GetFeaturedMemcardFail());
    when(mockMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardFail()));
    Widget widget = const ScrollableListCard();

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockMemcardCubit, widget);

    expect(find.byType(ListMemcardError), findsOneWidget);
  });

// cant test because this handle by swiper
//  testWidgets(
//       'Verify behavior UI of ListCardHolder widget', (widgetTester) async {
//       });
}
