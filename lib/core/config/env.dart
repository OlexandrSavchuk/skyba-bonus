enum Environment {
  dev,
  staging,
  prod;

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return 'http://localhost:3000/api/v1';
      case Environment.staging:
        return 'https://staging-api.skyba.com.ua/api/v1';
      case Environment.prod:
        return 'https://api.skyba.com.ua/api/v1';
    }
  }

  bool get isProduction => this == Environment.prod;
  bool get isDevelopment => this == Environment.dev;
}
