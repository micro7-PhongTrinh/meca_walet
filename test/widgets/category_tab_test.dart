import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/home/bloc/get_featured_product_cubit.dart';
import 'package:meca_wallet/features/home/featured_product.dart';
import 'package:meca_wallet/features/store/store_screen.dart';
import 'package:meca_wallet/model/featured_product.dart';
import 'package:meca_wallet/widgets/error/featured_product_error.dart';
import 'package:meca_wallet/widgets/selected_text_button.dart';
import 'package:meca_wallet/widgets/skeleton/featured_product_skeleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../widget_test_extention.dart';
import 'category_tab_test.mocks.dart';

@GenerateMocks(<Type>[GetFeaturedProductCubit])
void main() {
  final MockGetFeaturedProductCubit mockGetFeaturedProductCubit =
      MockGetFeaturedProductCubit();
  final List<String> mockCategories = [
    'Quần áo',
    'Coffee',
    'Nhà hàng',
    'Mua sắm',
    'Ăn vặt',
    'hhhhh',
    'dddddd',
    'fffffff',
    'pppppppp',
    'eeeeeeee'
  ];
  final List<FeaturedProductModel> mockProducts = [
    FeaturedProductModel('Tra sua', 'zzzzz', 'ihwewufh', 4.5),
    FeaturedProductModel('Banh mi', 'zzzzz', 'ihwewufh', 4.5),
    FeaturedProductModel('Dua luoi', 'zzzzz', 'ihwewufh', 4.5),
    FeaturedProductModel('Banht trang', 'zzzzzz', 'ihwewufh', 4.5)
  ];
  setUp(() {
    when(mockGetFeaturedProductCubit.state)
        .thenAnswer((_) => GetFeaturedProductSuccess(mockProducts));
    when(mockGetFeaturedProductCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedProductState>.value(
            GetFeaturedProductSuccess(mockProducts)));
  });

  tearDown(() {
    reset(mockGetFeaturedProductCubit);
  });

  testWidgets('Verify category tab UI', (widgetTester) async {
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    //drag button scroll view
    for (var element in mockCategories) {
      await widgetTester.dragUntilVisible(
          find.byKey(ValueKey(
              'tategory_filter_tab_${mockCategories.indexOf(element)}')),
          find.byKey(const ValueKey('tategory_filter_tab')),
          Offset.infinite);
      expect(
          find.byKey(ValueKey(
              'tategory_filter_tab_${mockCategories.indexOf(element)}')),
          findsOneWidget);
      await widgetTester.pumpAndSettle();
    }

    //drag product scroll view
    for (var element in mockProducts) {
      await widgetTester.dragUntilVisible(
          find.byKey(ValueKey(
              'tategory_product_tab_${mockProducts.indexOf(element)}')),
          find.byKey(const ValueKey('tategory_filter_tab')),
          Offset.infinite);
      expect(
          find.byKey(ValueKey(
              'tategory_product_tab_${mockProducts.indexOf(element)}')),
          findsOneWidget);
      await widgetTester.pumpAndSettle();
    }
  });
  testWidgets(
      'Change avtive button, active button and scroll to view when click',
      (widgetTester) async {
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));
    //scroll to widget and tap
    //offscreen button cant tap
    await widgetTester.dragUntilVisible(
        find.byKey(
            ValueKey('tategory_filter_tab_${mockCategories.length - 1}')),
        find.byKey(const ValueKey('tategory_filter_tab')),
        Offset.infinite);
    await widgetTester.tap(find.descendant(
        of: find.byKey(
            ValueKey('tategory_filter_tab_${mockCategories.length - 1}')),
        matching: find.byType(TextButton)));

    //wait to set new state
    await widgetTester.pumpAndSettle();

    expect(
        widgetTester.widget(find.byKey(
            ValueKey('tategory_filter_tab_${mockCategories.length - 1}'))),
        isA<SelectedTextButton>()
            .having((t) => t.isSelected, 'button is on selected', true));
  });
  testWidgets('Change active button and call to Bloc get list',
      (widgetTester) async {
    when(mockGetFeaturedProductCubit.state)
        .thenAnswer((_) => GetFeaturedProductSuccess(mockProducts));
    when(mockGetFeaturedProductCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedProductState>.value(
            GetFeaturedProductSuccess(mockProducts)));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    //scroll to widget and tap
    //offscreen button cant tap
    await widgetTester.dragUntilVisible(
        find.byKey(
            ValueKey('tategory_filter_tab_${mockCategories.length - 1}')),
        find.byKey(const ValueKey('tategory_filter_tab')),
        Offset.infinite);
    await widgetTester.tap(find.descendant(
        of: find.byKey(
            ValueKey('tategory_filter_tab_${mockCategories.length - 1}')),
        matching: find.byType(TextButton)));

    await widgetTester.pumpAndSettle();

    verify(mockGetFeaturedProductCubit.getFilteredProducts(mockCategories.last))
        .called(1);
    verify(mockGetFeaturedProductCubit.getFilteredProducts(mockCategories[0]))
        .called(1);
  });
  testWidgets('Call to Bloc get list with first category when init widget',
      (widgetTester) async {
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    await widgetTester.pumpAndSettle();

    verify(mockGetFeaturedProductCubit.getFilteredProducts(mockCategories[0]))
        .called(1);
  });
  testWidgets('When state is initial then check skeleton is presented',
      (widgetTester) async {
    when(mockGetFeaturedProductCubit.state)
        .thenAnswer((_) => GetFeaturedProductInitial());
    when(mockGetFeaturedProductCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedProductState>.value(GetFeaturedProductInitial()));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    expect(find.byType(FeaturedProductSkeleton), findsWidgets);
  });
  testWidgets('When state is loading then check skeleton is presented',
      (widgetTester) async {
    when(mockGetFeaturedProductCubit.state)
        .thenAnswer((_) => GetFeaturedProductLoading());
    when(mockGetFeaturedProductCubit.stream).thenAnswer((_) =>
        Stream<GetFeaturedProductState>.value(GetFeaturedProductLoading()));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    expect(find.byType(FeaturedProductSkeleton), findsWidgets);
  });
  testWidgets(
      'When state is load success then check list product in state is presented',
      (widgetTester) async {
    //state success from setup
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    await widgetTester.pumpAndSettle();

    for (var element in mockProducts) {
      expect(
          find.byKey(ValueKey(
              'tategory_product_tab_${mockProducts.indexOf(element)}')),
          findsOneWidget);
    }
  });
  testWidgets('When state is loading fail then image error is presented',
      (widgetTester) async {
    when(mockGetFeaturedProductCubit.state)
        .thenAnswer((_) => GetFeaturedProductFail());
    when(mockGetFeaturedProductCubit.stream).thenAnswer(
        (_) => Stream<GetFeaturedProductState>.value(GetFeaturedProductFail()));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories)));

    await widgetTester.pumpAndSettle();

    expect(find.byType(FeaturedProductError), findsOneWidget);
  });

  testWidgets(
      'When user tap on specific product then navigate them to store screen',
      (widgetTester) async {
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetFeaturedProductCubit>(
            mockGetFeaturedProductCubit, FeaturedProductBody(mockCategories),
            useRouter: true));

    await widgetTester.pumpAndSettle();

    // tap on product 0
    await widgetTester
        .tap(find.byKey(const ValueKey('tategory_product_tab_0')));

    await widgetTester.pumpAndSettle();

    expect(find.byType(StoreScreen), findsOneWidget);
  });
}
