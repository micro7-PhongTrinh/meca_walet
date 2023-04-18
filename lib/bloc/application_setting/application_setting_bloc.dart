import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:application_state/application_state.dart';

part 'application_setting_event.dart';
part 'application_setting_state.dart';

class ApplicationSettingBloc
    extends Bloc<ApplicationSettingEvent, ApplicationSettingState> {
  final ApplicationState _applicationState;
  ApplicationSettingBloc(ApplicationState applicationState)
      : _applicationState = applicationState,
        super(ApplicationInitialState()) {
    on<CheckUserLoggedinEvent>((ApplicationSettingEvent event,
        Emitter<ApplicationSettingState> emit) async {
      await _checkUserLoggedin(emit);
    });
    on<SaveUserLoggedinEvent>((ApplicationSettingEvent event,
        Emitter<ApplicationSettingState> emit) async {
      await _saveUserLoggedin(emit);
    });
  }

  // late StreamSubscription connectivitySubscription;

  Future<void> _checkUserLoggedin(Emitter<ApplicationSettingState> emit) async {
    try {
      await _applicationState.getIsLoggedin().then((bool value) {
        if (value == true) {
          emit(UserLoggedinState());
        }
      });
    } on StorageException {
      //TODOO catch execption when cant check user logged in
    }
  }

  Future<void> _saveUserLoggedin(Emitter<ApplicationSettingState> emit) async {
    try {
      await _applicationState.setIsLoggedin(true).then((value) {
        if (value == true) { 
          emit(SaveLoggedinSuccessState());
        }
      });
    } catch (e) {
      //TODOO catch execption when cant set user logged in
    }
  }
}
