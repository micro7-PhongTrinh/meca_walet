import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/store/bloc/get_product_cubit.dart';
import 'package:meca_wallet/features/store/widgets/store_product_card.dart';
import 'package:meca_wallet/features/store/widgets/store_products.dart';
import 'package:meca_wallet/model/featured_product.dart';
import 'package:meca_wallet/model/product_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../widget_test_extention.dart';
import 'store_product_test.mocks.dart';

@GenerateMocks(<Type>[GetProductCubit])
main() {
  MockGetProductCubit mockCubit = MockGetProductCubit();

  List<FeaturedProductModel> mockData = List.generate(
    4,
    (index) => FeaturedProductModel(
        ProductModel(
            '123123',
            'Bò sốt phô mai',
            'https://cdn.tgdd.vn/2022/05/CookRecipe/GalleryStep/thanh-pham-35.jpg',
            4.2),
        'https://botonhanphat.vn/wp-content/uploads/2021/10/Logo-Facebook_He%CC%A3%CC%82-Tho%CC%82%CC%81ng-Bo%CC%80-To%CC%9B-Nha%CC%82n-Pha%CC%81t.png',
        'Bò sốt hẻm'),
  );

  setUp(() async {
    when(mockCubit.state).thenAnswer((_) => GetProductInitial());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream<GetProductState>.value(GetProductInitial()));
  });

  testWidgets('Product can get product cubit from widget above',
      (widgetTester) async {
    Widget widget = const StoreProducts();

    await widgetTester.blocWrapAndPump<GetProductCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester
            .widget(find.byType(BlocBuilder<GetProductCubit, GetProductState>)),
        isA<BlocBuilder<GetProductCubit, GetProductState>>()
            .having((t) => t.bloc, 'is mockCubit?', mockCubit));
  });
  testWidgets('Verify UI store product widget', (widgetTester) async {
    Widget widget = const StoreProducts();

    await widgetTester.blocWrapAndPump<GetProductCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    expect(find.text('Sản phẩm nổi bật'), findsOneWidget);
    expect(find.byType(ListProduct), findsOneWidget);
  });
  testWidgets('Verify store widget will call get product from cubit',
      (widgetTester) async {
    Widget widget = const StoreProducts();

    await widgetTester.blocWrapAndPump<GetProductCubit>(mockCubit, widget);
    await widgetTester.pumpAndSettle();

    verify(mockCubit.getStoreProduct(any)).called(1);
  });
  testWidgets('When get event succees, expect find products on screen',
      (widgetTester) async {
    when(mockCubit.state).thenAnswer((_) => GetProductSuccess(mockData));
    when(mockCubit.stream).thenAnswer(
        (_) => Stream<GetProductState>.value(GetProductSuccess(mockData)));

    Widget widget = const StoreProducts();

    await mockNetworkImages(() async {
      await widgetTester.blocWrapAndPump<GetProductCubit>(mockCubit, widget);
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(StoreProductCard), findsNWidgets(mockData.length));
  });
}
