part of 'application_setting_bloc.dart';

class ApplicationSettingEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckUserLoggedinEvent extends ApplicationSettingEvent {}
class SaveUserLoggedinEvent extends ApplicationSettingEvent {}
