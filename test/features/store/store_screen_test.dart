import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/store/bloc/get_store_infor_cubit.dart';
import 'package:meca_wallet/features/store/store_screen.dart';
import 'package:meca_wallet/features/store/widgets/store_appbar.dart';
import 'package:meca_wallet/model/store_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../widget_test_extention.dart';
import 'store_screen_test.mocks.dart';

@GenerateMocks(<Type>[GetStoreInforCubit])
main() {
  MockGetStoreInforCubit mockCubit = MockGetStoreInforCubit();
  StoreModel mockStoreData = StoreModel(
      '123',
      'Cheese Coffee',
      'https://estellaplace.com.vn/Data/Sites/1/Product/169/logo-cheese-coffee.jpg',
      [
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizXQTdjlQFCefarU1MJ0ln_pFAdJcdamb7a8QkQfO1WhFLLKyGwfCxMZRF7fOGpZ_CBsMNUB5GMdaNd-lKiqOgtGQY9yya9AaqyzOR8j7FkLnhgchcstUJFWzjT9EA-mIqhvfj0JHrhPBvO75-ByYqleezTTv2aGk9Gw_C83B8Ry3HB6Y9sBE7shJ61A/s2048/327762390_896909361764303_3259098495477982303_n.jpeg',
        'https://channel.mediacdn.vn/2020/12/18/95be3217-df91-41e4-9744-5fc0df3447e4-2535-0000021541c1d01f-1608276135326363235104.jpg'
      ],
      '123123',
      45);
  testWidgets('Verify store screen include store infor cubit',
      (widgetTester) async {
    Widget widget = const StoreScreen();

    await mockNetworkImages(() async {
      await widgetTester.wrapAndPump(widget);
    });

    expect(find.byType(BlocProvider<GetStoreInforCubit>), findsOneWidget);
  });
  testWidgets(
      'When navigate to store screen, will call get infor store cubit method',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetStoreInforInitial());
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetStoreInforState>.value(GetStoreInforInitial()));

    Widget widget = StoreScreenView();
    await widgetTester.blocWrapAndPump<GetStoreInforCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    verify(mockCubit.getStoreInfor(any)).called(1);
  });

  testWidgets(
      'When get store infor success, verify UI store screen when first render',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetStoreInforSuccess(mockStoreData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetStoreInforState>.value(GetStoreInforSuccess(mockStoreData)));

    Widget widget = StoreScreenView();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetStoreInforCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(StoreScreenAppBar), findsOneWidget);
    expect(find.text('Thẻ thành viên'), findsOneWidget);
  });
  testWidgets(
      'When get store infor success, user scroll down, will see happening event',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetStoreInforSuccess(mockStoreData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetStoreInforState>.value(GetStoreInforSuccess(mockStoreData)));

    Widget widget = StoreScreenView();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetStoreInforCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    await widgetTester.ensureVisible(find.text('Sự kiện đang diễn ra'));
    await widgetTester.pumpAndSettle();

    expect(find.text('Sự kiện đang diễn ra'), findsOneWidget);
  });

  testWidgets(
      'When get store infor success, user scroll down, will see featured product of store',
      (widgetTester) async {
    when(mockCubit.state)
        .thenAnswer((realInvocation) => GetStoreInforSuccess(mockStoreData));
    when(mockCubit.stream).thenAnswer((realInvocation) =>
        Stream<GetStoreInforState>.value(GetStoreInforSuccess(mockStoreData)));

    Widget widget = StoreScreenView();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetStoreInforCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    await widgetTester.ensureVisible(find.text('Sự kiện đang diễn ra'));
    await widgetTester.pumpAndSettle();

    expect(find.text('Sản phẩm nổi bật'), findsOneWidget);
  });
}
