class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://192.168.1.5:3000/api';
  static const String fallbackBaseUrl = 'http://localhost:3000/api';

  static const String syncEndpoint = '/sync';
  static const String authEndpoint = '/auth';
  static const String healthEndpoint = '/health';

  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration syncInterval = Duration(minutes: 5);

  static const int maxRetries = 3;
}
