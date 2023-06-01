import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/searhing_store/bloc/get_filtered_stores_cubit.dart';
import 'package:meca_wallet/features/searhing_store/searching_store_screen.dart';
import 'package:meca_wallet/features/searhing_store/widgets/searching_stores_result.dart';
import 'package:meca_wallet/features/searhing_store/widgets/store_suggest.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../widget_test_extention.dart';
import 'searching_store_screen_test.mocks.dart';

@GenerateMocks(<Type>[GetFilteredStoresCubit])
void main() {
  TextEditingController mockTextController = TextEditingController();
  final MockGetFilteredStoresCubit mockCubit = MockGetFilteredStoresCubit();

  setUp(() async {
    mockTextController = TextEditingController();
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFilteredStoresInitial());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFilteredStoresState>.value(GetFilteredStoresInitial()));
  });

  tearDown(() async {
    reset(mockCubit);
  });
  testWidgets('Verify searching store screen UI', (widgetTester) async {
    Widget widget = const SearchingStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(SearchingStoreAppbar), findsOneWidget);
    expect(find.byType(ResultBody), findsOneWidget);
  });
  testWidgets('Verify searching store screen include get store cubit',
      (widgetTester) async {
    Widget widget = const SearchingStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(BlocProvider<GetFilteredStoresCubit>), findsOneWidget);
  });
  testWidgets(
      'Given search text field is empty, expect suggest item will be showed',
      (widgetTester) async {
    mockTextController.text = '';
    Widget widget = ResultBody(textController: mockTextController);

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
          mockCubit, widget);
    });

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(StoreSuggest), findsOneWidget);
  });
  testWidgets(
      'Given search text field have input, expect filtered store will be showed',
      (widgetTester) async {
    mockTextController.text = 'kkk';
    Widget widget = ResultBody(textController: mockTextController);

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
          mockCubit, widget);
    });

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(SearchingStoreResult), findsOneWidget);
    expect(
        widgetTester.widget(
          find.byType(SearchingStoreResult),
        ),
        isA<SearchingStoreResult>().having((t) => t.searchString,
            'searching match text controller value', mockTextController.text));
  });
  testWidgets(
      'When user enter new text is not empty, expect filtered store with new input will be showed',
      (widgetTester) async {
    String inputText = 'text';
    Widget widget = const SearchingStoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(StoreSuggest), findsOneWidget);

    await widgetTester.enterText(find.byType(TextFormField), inputText);

    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(SearchingStoreResult), findsOneWidget);
    expect(
        widgetTester.widget(
          find.byType(SearchingStoreResult),
        ),
        isA<SearchingStoreResult>().having((t) => t.searchString,
            'searching match text controller value', inputText));
  });
}
