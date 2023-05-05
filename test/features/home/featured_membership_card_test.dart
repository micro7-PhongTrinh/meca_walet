import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_memcard_cubit.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/home/widgets/featured_membership_card.dart';
import 'package:meca_wallet/features/overview_membership_card/overview_membership_card_screen.dart';
import 'package:meca_wallet/model/membership_card.dart';
import 'package:meca_wallet/widgets/error/featured_memcard_error.dart';
import 'package:meca_wallet/widgets/membership_store_card.dart';
import 'package:meca_wallet/widgets/skeleton/membership_card_skeleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_test_extention.dart';
import 'featured_membership_card_test.mocks.dart';

@GenerateMocks(<Type>[GetFeaturedMemcardCubit])
void main() {
  final MockGetFeaturedMemcardCubit mockGetFeaturedMemcardCubit =
      MockGetFeaturedMemcardCubit();

  final List<MembershipCardModel> mockMembershipCards = [
    MembershipCardModel(
        'Visa', 'assets/images/visa_logo.png', 'Phong Trinh', 18, 12, cardColors[0]),
    MembershipCardModel(
        'Jollibee', 'assets/images/jollibee_logo.png', 'Phong Trinh', 17, 7, cardColors[1]),
    MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
        'Phong Trinh', 23, 9, cardColors[2])
  ];

  setUp(() {
    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardSuccess(mockMembershipCards, 8));
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(
            GetFeaturedMemcardSuccess(mockMembershipCards, 8)));
  });

  tearDown(() {
    reset(mockGetFeaturedMemcardCubit);
  });

  testWidgets(
      'verify membership card wallet widget was wraped with GetFeaturedMemcardCubit',
      (widgetTester) async {
    const Widget widget = FeaturedMembershipCard();
    await widgetTester.wrapAndPump(widget);

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(BlocProvider<GetFeaturedMemcardCubit>), findsOneWidget);
  });
  testWidgets('verify call cubit to get membership card when init widget',
      (widgetTester) async {
    const Widget widget = FeaturedMembershipCardBody();

    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardInitial());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardInitial()));

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);

    verify(mockGetFeaturedMemcardCubit.getMembershipCardContent()).called(1);
  });
  testWidgets('verify UI membership card wallet widget', (widgetTester) async {
    const Widget widget = FeaturedMembershipCardBody();

    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardInitial());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardInitial()));

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);

    expect(find.byType(FeaturedMembershipCardHolder), findsOneWidget);
  });
  testWidgets(
      'Navigate to membership card management screen when tap on "All" button',
      (widgetTester) async {
    const Widget widget = FeaturedMembershipCardHeader();

    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardInitial());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardInitial()));

    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget,
        useRouter: true);

    await widgetTester.tap(find.byType(InkWell));

    await widgetTester.pumpAndSettle();

    expect(find.byType(OverviewMembershipCardScreen), findsOneWidget);
  });
  testWidgets(
      'When state in get cards initial, then loading card skeleton is presented',
      (widgetTester) async {
    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardInitial());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardInitial()));

    Widget widget = const FeaturedMembershipCardBody();
    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(MembershipCardSkeleton), findsOneWidget);
  });
  testWidgets(
      'When state in get cards loading, then image loading card is presented',
      (widgetTester) async {
    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardLoading());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardLoading()));

    Widget widget = const FeaturedMembershipCardBody();
    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(MembershipCardSkeleton), findsWidgets);
  });
  testWidgets('When state in get cards success, then list card is presented',
      (widgetTester) async {
    //state from set up
    Widget widget = const FeaturedMembershipCardHolder();
    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(MembershipStoreCard),
        findsNWidgets(mockMembershipCards.length));
  });
  testWidgets(
      'When state in get cards failed, then get membership card error widget is presented',
      (widgetTester) async {
    when(mockGetFeaturedMemcardCubit.state)
        .thenAnswer((_) => GetFeaturedMemcardFail());
    when(mockGetFeaturedMemcardCubit.stream).thenAnswer(
        (_) => Stream<GetFeaturedMemcardState>.value(GetFeaturedMemcardFail()));

    Widget widget = const FeaturedMembershipCardBody();
    await widgetTester.blocWrapAndPump<GetFeaturedMemcardCubit>(
        mockGetFeaturedMemcardCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(FeaturedMemcardError), findsOneWidget);
  });
}
