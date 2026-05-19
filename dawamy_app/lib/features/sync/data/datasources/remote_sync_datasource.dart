import '../../../../services/http_service.dart';
import '../../../../core/constants/api_constants.dart';

class RemoteSyncDatasource {
  final HttpService _http;

  RemoteSyncDatasource(this._http);

  Future<bool> syncAll() async {
    try {
      final response = await _http.dio.post(
        ApiConstants.syncEndpoint,
        data: {'action': 'sync_all', 'timestamp': DateTime.now().toIso8601String()},
      );
      return response.statusCode == 200;
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchRemoteData(String userId) async {
    try {
      final response = await _http.dio.get(
        ApiConstants.syncEndpoint,
        queryParameters: {'userId': userId},
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> pushData(String userId, Map<String, dynamic> data) async {
    try {
      final response = await _http.dio.post(
        ApiConstants.syncEndpoint,
        data: {'userId': userId, 'data': data},
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
