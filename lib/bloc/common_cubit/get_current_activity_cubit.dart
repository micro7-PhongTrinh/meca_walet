import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/activity.dart';
import 'package:meca_service/meca_service.dart';

part 'get_current_activity_state.dart';

class GetCurrentActivityCubit extends Cubit<GetCurrentActivityState> {
  GetCurrentActivityCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetCurrentActivityInitial());

  final MecaService _mecaService;

  Future<void> getLatelyActivities() async {
    emit(GetCurrentActivityLoading());

    try {
      List<Activity> activities = await _mecaService.getLatelyActivity();
      emit(GetCurrentActivitySuccess(activities));
    } catch (e) {
      emit(GetCurrentActivityFail());
    }
  }

  Future<void> getActivitiesByMemberCard(String cardId) async {
    emit(GetCurrentActivityLoading());

    try {
      List<Activity> activities =
          await _mecaService.getActivityByMemberCard(cardId);
      if (activities.isEmpty) {
        emit(EmptyActivity());
      } else {
        emit(GetCurrentActivitySuccess(activities));
      }
    } catch (e) {
      emit(GetCurrentActivityFail());
    }
  }
}
