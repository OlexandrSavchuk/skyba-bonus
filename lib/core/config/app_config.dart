class AppConfig {
  const AppConfig._();

  static const String baseUrl = 'https://app.skyba.ua/api/v1';

  // companyId is now per-region, selected by user during auth.
  // Companies are fetched from GET /companies endpoint.

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const int paginationLimit = 20;
}
