part of 'authentication_bloc.dart';

enum AutheticationStatus {
  initial,
  authenticated,
  unauthenticated,
}

abstract class AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticatedState(this.user);
}

class UnauthenticatedState extends AuthenticationState {
  UnauthenticatedState();
}

class AuthenticationInitailState extends AuthenticationState {
  AuthenticationInitailState();
}
