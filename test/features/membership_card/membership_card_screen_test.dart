import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_memcard_cubit.dart';
import 'package:meca_wallet/features/overview_membership_card/bloc/get_current_activity_cubit.dart';
import 'package:meca_wallet/features/overview_membership_card/overview_membership_card_screen.dart';
import 'package:meca_wallet/features/overview_membership_card/widgets/list_recent_activity.dart';
import 'package:meca_wallet/features/overview_membership_card/widgets/scrollable_list_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../widget_test_extention.dart';

@GenerateMocks(<Type>[GetFeaturedMemcardCubit, GetCurrentActivityCubit])
main() {
  testWidgets(
      'Verify memcard screen include 2 cubit: memcard cubit and activity cubit',
      (widgetTester) async {
    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(const OverviewMembershipCardScreen());
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      expect(
          find.byType(BlocProvider<GetFeaturedMemcardCubit>), findsOneWidget);
      expect(
          find.byType(BlocProvider<GetCurrentActivityCubit>), findsOneWidget);
    });
  });
  testWidgets('Verify UI of membership card screen', (widgetTester) async {
    Widget widget = const OverviewMembershipCardScreen();
    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(ScrollableListCard), findsOneWidget);
      expect(find.byType(ListRecentActivity), findsOneWidget);
    });
  });
}
