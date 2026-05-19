import 'package:dio/dio.dart';
import '../../../calendar/domain/models/month_data.dart';
import '../../../calendar/domain/models/day_data.dart';
import '../../../../core/constants/api_constants.dart';

class RemoteCalendarDatasource {
  final Dio _dio;

  RemoteCalendarDatasource(this._dio);

  Future<MonthData?> getMonthData(String userId, int year, int month) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.syncEndpoint}',
        queryParameters: {
          'userId': userId,
          'year': year,
          'month': month,
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        return MonthData.fromJson(response.data as Map<String, dynamic>);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> saveMonthData(String userId, MonthData monthData) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.syncEndpoint}',
        data: {
          'userId': userId,
          'data': monthData.toJson(),
        },
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> saveDayData(String userId, DayData dayData) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.syncEndpoint}',
        data: {
          'userId': userId,
          'data': dayData.toJson(),
          'type': 'day',
        },
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
