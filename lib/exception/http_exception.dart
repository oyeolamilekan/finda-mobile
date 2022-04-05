class CustomException implements Exception {
  final String? _message;
  final String? _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class TimeOutException extends CustomException {
  TimeOutException([String? message]) : super(message, "Timeout exceptions: ");
}

class ServiceUnavailable extends CustomException {
  ServiceUnavailable([String? message])
      : super(message, "Error During Communication: ");
}

class DataNotFoundException extends CustomException {
  DataNotFoundException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class ConflictRequestException extends CustomException {
  ConflictRequestException([String? message])
      : super(message, "Item already exit Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}
