import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_featured_stores_cubit.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item_skeleton.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_stores.dart';
import 'package:meca_wallet/model/store_model.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_test_extention.dart';
import '../explore_store_screen_test.mocks.dart';

void main() {
  MockGetFeaturedStoresCubit mockCubit = MockGetFeaturedStoresCubit();

  List<StoreModel> mockData = List.generate(
      4,
      (index) => StoreModel(
          '123',
          'Dưa Lưới Coffee',
          'https://duhocsunny.edu.vn/wp-content/uploads/2020/05/4-tiem-tra-sua-khuay-dao-gioi-tre-han-quoc-3.jpg',
          [
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizXQTdjlQFCefarU1MJ0ln_pFAdJcdamb7a8QkQfO1WhFLLKyGwfCxMZRF7fOGpZ_CBsMNUB5GMdaNd-lKiqOgtGQY9yya9AaqyzOR8j7FkLnhgchcstUJFWzjT9EA-mIqhvfj0JHrhPBvO75-ByYqleezTTv2aGk9Gw_C83B8Ry3HB6Y9sBE7shJ61A/s2048/327762390_896909361764303_3259098495477982303_n.jpeg',
            'https://channel.mediacdn.vn/2020/12/18/95be3217-df91-41e4-9744-5fc0df3447e4-2535-0000021541c1d01f-1608276135326363235104.jpg'
          ],
          '123123',
          45));

  setUp(() async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedStoresInitial());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedStoresState>.value(GetFeaturedStoresInitial()));
  });

  tearDown(() async {
    reset(mockCubit);
  });
  testWidgets('Verify featured stores UI', (widgetTester) async {
    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(find.text('Cửa hàng nổi bật'), findsOneWidget);
    expect(find.byType(FeaturedStoreItems), findsOneWidget);
  });
  testWidgets('Verify featred stores will get cubit from above widget',
      (widgetTester) async {
    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(
        widgetTester.widget(find.byType(
            BlocBuilder<GetFeaturedStoresCubit, GetFeaturedStoresState>)),
        isA<BlocBuilder<GetFeaturedStoresCubit, GetFeaturedStoresState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
  });
  testWidgets('When state is initial, expect list skeleton appear',
      (widgetTester) async {
    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
  testWidgets('When state is success, expect list featured store appear',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedStoresSuccess(mockData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedStoresState>.value(
            GetFeaturedStoresSuccess(mockData)));

    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItem), findsNWidgets(mockData.length));
  });
  testWidgets('Whenn state is loading, expect list skeleton appear',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedStoresLoading());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedStoresState>.value(GetFeaturedStoresLoading()));

    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
  testWidgets('When state is load fail, expect list skeleton appear',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetFeaturedStoresFail());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetFeaturedStoresState>.value(GetFeaturedStoresFail()));

    Widget widget = const FeaturedStores();

    await widgetTester.blocWrapAndPump<GetFeaturedStoresCubit>(
        mockCubit, widget);

    expect(find.byType(FeaturedItemSkeleton), findsWidgets);
  });
}
