import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/searhing_store/bloc/get_filtered_stores_cubit.dart';
import 'package:meca_wallet/features/searhing_store/widgets/store_suggest.dart';
import 'package:meca_wallet/features/searhing_store/widgets/suggest_item.dart';
import 'package:meca_wallet/features/searhing_store/widgets/suggest_item_skeleton.dart';
import 'package:meca_wallet/model/store_model.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_test_extention.dart';
import '../searching_store_screen_test.mocks.dart';

void main() {
  final MockGetFilteredStoresCubit mockCubit = MockGetFilteredStoresCubit();
  List<StoreModel> mockData = List.generate(
      4,
      (index) => StoreModel(
          '123',
          'Cheese Coffee',
          'https://estellaplace.com.vn/Data/Sites/1/Product/169/logo-cheese-coffee.jpg',
          [
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizXQTdjlQFCefarU1MJ0ln_pFAdJcdamb7a8QkQfO1WhFLLKyGwfCxMZRF7fOGpZ_CBsMNUB5GMdaNd-lKiqOgtGQY9yya9AaqyzOR8j7FkLnhgchcstUJFWzjT9EA-mIqhvfj0JHrhPBvO75-ByYqleezTTv2aGk9Gw_C83B8Ry3HB6Y9sBE7shJ61A/s2048/327762390_896909361764303_3259098495477982303_n.jpeg',
            'https://channel.mediacdn.vn/2020/12/18/95be3217-df91-41e4-9744-5fc0df3447e4-2535-0000021541c1d01f-1608276135326363235104.jpg'
          ],
          '123123',
          45));

  setUp(() async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFilteredStoresInitial());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFilteredStoresState>.value(GetFilteredStoresInitial()));
  });

  tearDown(() async {
    reset(mockCubit);
  });

  testWidgets('Verify store suggest UI', (widgetTester) async {
    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(find.text('Các gợi ý cửa hàng'), findsOneWidget);
    expect(find.byType(SuggestStoreBody), findsOneWidget);
  });
  testWidgets('Verify will get cubit from widget above', (widgetTester) async {
    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetFilteredStoresCubit, GetFilteredStoresState>)),
        isA<BlocBuilder<GetFilteredStoresCubit, GetFilteredStoresState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
  });

  testWidgets(
      'Verify store suggest will call getSuggestStores() method cubit every build',
      (widgetTester) async {
    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    verify(mockCubit.getSuggestStores()).called(1);
  });

  testWidgets('When state is initial, expect skeleton is showed',
      (widgetTester) async {
    //state from setup
    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(find.byType(SuggestItemSkeleton), findsWidgets);
  });
  testWidgets('When state is success, expect suggestItems is showed',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFilteredStoresSuccess(mockData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFilteredStoresState>.value(
            GetFilteredStoresSuccess(mockData)));

    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(find.byType(SuggestItem), findsNWidgets(mockData.length));
  });
  testWidgets('When state is loading, expect skeleton is showed',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFilteredStoresLoading());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFilteredStoresState>.value(GetFilteredStoresLoading()));

    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(find.byType(SuggestItemSkeleton), findsWidgets);
  });
  testWidgets('When state is fail, expect skeleton is showed',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFilteredStoresFail());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFilteredStoresState>.value(GetFilteredStoresFail()));

    Widget widget = const StoreSuggest();

    await widgetTester.blocWrapAndPump<GetFilteredStoresCubit>(
        mockCubit, widget);

    await widgetTester.pumpAndSettle();

    expect(find.byType(SuggestItemSkeleton), findsWidgets);
  });
}
