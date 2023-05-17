import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/store_model.dart';

part 'get_filtered_stores_state.dart';

class GetFilteredStoresCubit extends Cubit<GetFilteredStoresState> {
  GetFilteredStoresCubit() : super(GetFilteredStoresInitial());

  Future<void> getFilteredStores(String searchString) async {
    emit(GetFilteredStoresLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<StoreModel> stores = List.generate(
        searchString.length > 4 ? 4 : 10,
        (index) => StoreModel(
            '123',
            'Cheese Coffee',
            'https://estellaplace.com.vn/Data/Sites/1/Product/169/logo-cheese-coffee.jpg',
            [
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizXQTdjlQFCefarU1MJ0ln_pFAdJcdamb7a8QkQfO1WhFLLKyGwfCxMZRF7fOGpZ_CBsMNUB5GMdaNd-lKiqOgtGQY9yya9AaqyzOR8j7FkLnhgchcstUJFWzjT9EA-mIqhvfj0JHrhPBvO75-ByYqleezTTv2aGk9Gw_C83B8Ry3HB6Y9sBE7shJ61A/s2048/327762390_896909361764303_3259098495477982303_n.jpeg',
              'https://channel.mediacdn.vn/2020/12/18/95be3217-df91-41e4-9744-5fc0df3447e4-2535-0000021541c1d01f-1608276135326363235104.jpg'
            ],
            '123123', 45));

    emit(GetFilteredStoresSuccess(stores));
  }

  Future<void> getSuggestStores() async {
    emit(GetFilteredStoresLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<StoreModel> stores = List.generate(
        4,
        (index) => StoreModel(
            '123',
            'Cheese Coffee',
            'https://estellaplace.com.vn/Data/Sites/1/Product/169/logo-cheese-coffee.jpg',
            [
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizXQTdjlQFCefarU1MJ0ln_pFAdJcdamb7a8QkQfO1WhFLLKyGwfCxMZRF7fOGpZ_CBsMNUB5GMdaNd-lKiqOgtGQY9yya9AaqyzOR8j7FkLnhgchcstUJFWzjT9EA-mIqhvfj0JHrhPBvO75-ByYqleezTTv2aGk9Gw_C83B8Ry3HB6Y9sBE7shJ61A/s2048/327762390_896909361764303_3259098495477982303_n.jpeg',
              'https://channel.mediacdn.vn/2020/12/18/95be3217-df91-41e4-9744-5fc0df3447e4-2535-0000021541c1d01f-1608276135326363235104.jpg'
            ],
            '123123', 45));

    emit(GetFilteredStoresSuccess(stores));
  }
}
