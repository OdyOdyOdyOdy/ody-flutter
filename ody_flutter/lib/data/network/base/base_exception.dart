enum BaseExceptionType {
  clientError,
  unauthorizedUser,
  invalidData,
  serverError,
  unexpectedError,
}

extension _BadResponseExceptionMessage on BaseExceptionType {
  String toPrettyDescription() {
    switch (this) {
      case BaseExceptionType.clientError:
        return "client error";
      case BaseExceptionType.unauthorizedUser:
        return "unauthorized user";
      case BaseExceptionType.invalidData:
        return "invalid data";
      case BaseExceptionType.serverError:
        return "server error";
      case BaseExceptionType.unexpectedError:
        return "unexpected error";
    }
  }
}

class BaseException implements Exception {
  BaseException({
    required this.type,
    this.message,
  });

  factory BaseException.clientError() => BaseException(
        type: BaseExceptionType.clientError,
        message: "The request is invalid or malformed.",
      );

  factory BaseException.unauthorizedUser() => BaseException(
        type: BaseExceptionType.unauthorizedUser,
        message: "Authentication is required or has failed.",
      );

  factory BaseException.invalidData() => BaseException(
        type: BaseExceptionType.invalidData,
        message: "The requested resource could not be found.",
      );

  factory BaseException.serverError() => BaseException(
        type: BaseExceptionType.serverError,
        message: "An unexpected server error occurred.",
      );

  factory BaseException.unexpectedError({String? message}) => BaseException(
        type: BaseExceptionType.unexpectedError,
        message: message,
      );

  final BaseExceptionType type;
  final String? message;

  @override
  String toString() =>
      "BaseException [${type.toPrettyDescription()}]: $message";
}
