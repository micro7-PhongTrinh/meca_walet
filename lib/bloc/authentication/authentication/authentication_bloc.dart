import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';

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
    _mecaService.user.listen((user) {
      add(UserChanged(user));
    });
  }

  final MecaService _mecaService;

  void _onUserChanged(UserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user != null
          ? AuthenticatedState(event.user!)
          : UnauthenticatedState(),
    );
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_mecaService.signout());
  }

  Future<void> _onCheckUserLoggedIn(
      CheckUserLoggedIn evnt, Emitter<AuthenticationState> emit) async {
    try {
      await _mecaService.checkSignedinUser();
    } catch (e) {
      print(e.toString());
      emit(UnauthenticatedState());
    }
  }
}
