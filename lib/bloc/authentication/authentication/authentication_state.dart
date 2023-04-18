part of 'authentication_bloc.dart';

enum AutheticationStatus {
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AutheticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AutheticationStatus.unauthenticated);

  final AutheticationStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}