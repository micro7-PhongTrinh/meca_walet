class RequestFailException implements Exception {
  final String error;

  RequestFailException(this.error);
}

class InvalidInputException extends RequestFailException {
  InvalidInputException(super.error);
}
