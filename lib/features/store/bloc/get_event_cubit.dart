import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/event.dart';
import 'package:meca_service/meca_service.dart';

part 'get_event_state.dart';

class GetEventCubit extends Cubit<GetEventState> {
  GetEventCubit({required mecaService}) 
      : _mecaService = mecaService,
       super(GetEventInitial());

final MecaService _mecaService;

  Future<void> getHappeningStoreEvent(String storeId) async {
    List<Event> events = await _mecaService.getHappeningStoreEvent(storeId);
    emit(GetEventSuccess(events));
  }
}
