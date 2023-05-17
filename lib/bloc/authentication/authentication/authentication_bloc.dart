import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        super(AuthenticationInitailState()) {
    on<UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckUserLoggedIn>(_onCheckUserLoggedIn);
    // _userSubscription = _authenticationService.user.listen(
    //   (user) => add(_UserChanged(user)),
    // );
  }

  final AuthenticationService _authenticationService;

  void _onUserChanged(UserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user != null
          ? AuthenticatedState(event.user!)
          : UnauthenticatedState(),
    );
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationService.signoutGoogle());
  }

  Future<void> _onCheckUserLoggedIn(
      CheckUserLoggedIn evnt, Emitter<AuthenticationState> emit) async {
    try {
      User user = await _authenticationService.checkLoggedInUser();
      emit(AuthenticatedState(user));
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }
}
