part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();
}

class UserChanged extends AuthenticationEvent {
  const UserChanged(this.user);

  final User? user;
}

class CheckUserLoggedIn extends AuthenticationEvent {
  const CheckUserLoggedIn();
}

class FirstUserLoggedin extends AuthenticationEvent {
  const FirstUserLoggedin();
}
