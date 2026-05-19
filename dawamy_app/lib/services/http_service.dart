import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/api_constants.dart';

class HttpService {
  late final Dio dio;
  final bool useFallback;

  HttpService({this.useFallback = false}) {
    dio = Dio(BaseOptions(
      baseUrl: useFallback ? ApiConstants.fallbackBaseUrl : ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    dio.interceptors.add(RetryInterceptor());
  }

  Future<bool> testConnection() async {
    try {
      final response = await dio.get(ApiConstants.healthEndpoint);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

class RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      for (int i = 0; i < ApiConstants.maxRetries; i++) {
        try {
          await Future.delayed(Duration(seconds: 2 * (i + 1)));
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (_) {
          continue;
        }
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}

final httpServiceProvider = Provider<HttpService>((ref) {
  return HttpService(useFallback: true);
});
