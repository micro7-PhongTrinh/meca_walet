import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/event_model.dart';

part 'get_featured_events_state.dart';

class GetFeaturedEventsCubit extends Cubit<GetFeaturedEventsState> {
  GetFeaturedEventsCubit() : super(GetFeaturedEventsInitial());

  Future<void> getFeaturedEvents() async {
    emit(GetFeaturedEventsLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<EventModel> events = List.generate(
        4,
        (index) => EventModel(
            'Chương trình tích thẻ thành viên với Meca',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTshVuqsxo_De8yDZK8a7PrtEHizBQlqhP-FEIk6vAWaA&s',
            DateTime(2023, 5, 5),
            DateTime(2023, 5, 23),
            '123'));

    emit(GetFeaturedEventsSuccess(events));
  }
}
