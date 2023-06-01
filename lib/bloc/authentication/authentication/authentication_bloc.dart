import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required MecaService mecaService})
      : _mecaService = mecaService,
        super(AuthenticationInitailState()) {
    on<UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckUserLoggedIn>(_onCheckUserLoggedIn);
    on<FirstUserLoggedin>(_setFirstUserLoggin);
    _mecaService.user.listen((user) {
      add(UserChanged(user));
    });
  }

  final MecaService _mecaService;

  User? user;

  void _onUserChanged(UserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user != null
          ? AuthenticatedState(event.user!)
          : UnauthenticatedState(),
    );

    user = event.user;
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_mecaService.signout());
  }

  Future<void> _onCheckUserLoggedIn(
      CheckUserLoggedIn evnt, Emitter<AuthenticationState> emit) async {
    bool isFirstLogin = await _isFirstUserLoggin();
    if (isFirstLogin == true) {
      emit(UserFirstLoginState());
      return;
    }
    try {
      await _mecaService.checkSignedinUser();
    } catch (e) {
      print(e.toString());
      emit(UnauthenticatedState());
    }
  }

  Future<bool> _isFirstUserLoggin() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool? check = sharedPrefs.getBool(keyIsfirstLogin);
    if (check == null || check == false) {
      return true;
    }
    return false;
  }

  Future<void> _setFirstUserLoggin(
      FirstUserLoggedin evnt, Emitter<AuthenticationState> emit) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(keyIsfirstLogin, true);
  }
}

const String keyIsfirstLogin = "isFirstLogin";
