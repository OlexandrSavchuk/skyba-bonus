class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Необхідна авторизація',
    super.statusCode = 401,
  });
}

class NetworkException extends ApiException {
  const NetworkException({
    super.message = 'Помилка мережі. Перевірте підключення до інтернету.',
    super.statusCode,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Ресурс не знайдено',
    super.statusCode = 404,
  });
}

class ServerException extends ApiException {
  const ServerException({
    super.message = 'Помилка сервера. Спробуйте пізніше.',
    super.statusCode = 500,
  });
}
