import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/event_card.dart';

part 'get_event_state.dart';

class GetEventCubit extends Cubit<GetEventState> {
  GetEventCubit() : super(GetEventInitial());

  Future<void> getStoreEvent(String storeId) async {
    await Future.delayed(Duration(seconds: 1));
    emit(GetEventSuccess([
      EventCardModel(
          'Chương trình tích thẻ thành viên với Meca',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTshVuqsxo_De8yDZK8a7PrtEHizBQlqhP-FEIk6vAWaA&s',
          DateTime(2023, 5, 5),
          DateTime(2023, 5, 23)),
      EventCardModel(
          'Mua hàng lần đầu tại Cheese Coffee',
          'https://images.foody.vn/res/g66/652833/prof/s1242x600/image-0f237865-221019091025.jpeg',
          DateTime(2023, 5, 5),
          DateTime(2023, 5, 23))
    ]));
  }
}
