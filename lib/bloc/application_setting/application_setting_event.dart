part of 'application_setting_bloc.dart';

class ApplicationSettingEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckUserFirstLoginEvent extends ApplicationSettingEvent {}
class SaveUserLoggedinEvent extends ApplicationSettingEvent {}
