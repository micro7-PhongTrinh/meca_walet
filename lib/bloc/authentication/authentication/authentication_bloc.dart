import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        super(
          authenticationService.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationService.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    on<_UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationService.user.listen(
      (user) => add(_UserChanged(user)),
    );
  }

  final AuthenticationService _authenticationService;
  late final StreamSubscription<UserModel> _userSubscription;

  void _onUserChanged(_UserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthenticationState.authenticated(event.user)
          : const AuthenticationState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationService.signoutGoogle());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
