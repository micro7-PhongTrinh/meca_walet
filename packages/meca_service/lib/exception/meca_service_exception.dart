class MecaServiceException implements Exception {
  final String error;

  MecaServiceException(this.error);
}

class UnauthenticatedRequest extends MecaServiceException {
  UnauthenticatedRequest(super.error);
}

class OtherException extends MecaServiceException {
  OtherException(super.error);
}

class DataMappingException extends MecaServiceException {
  DataMappingException(super.error);
}

class SigninFailRequest extends MecaServiceException {
  SigninFailRequest(super.error);
}
