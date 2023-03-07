class AuthenticationException implements Exception {
  final String error;

  AuthenticationException(this.error);
}

class AuthenticationFailedException extends AuthenticationException {
  AuthenticationFailedException(super.error);
  AuthenticationFailedException.userCanceled()
      : super('Canceld sign in process');
  AuthenticationFailedException.userNotFound() : super('No user found');
  AuthenticationFailedException.otherError()
      : super('Failed when sign in account');

  bool get isUserCanceled => error == 'Canceld sign in process';
}
