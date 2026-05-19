import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/http_service.dart';
import '../features/calendar/data/datasources/local_calendar_datasource.dart';
import '../features/shifts/data/datasources/local_shift_datasource.dart';
import '../features/auth/data/datasources/local_auth_datasource.dart';
import '../features/auth/data/datasources/remote_auth_datasource.dart';
import '../features/store/data/datasources/local_store_datasource.dart';
import '../features/sync/data/datasources/local_sync_datasource.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';

final diContainerProvider = Provider((ref) => DiContainer(ref));

class DiContainer {
  final Ref _ref;

  DiContainer(this._ref);

  HttpService get httpService => _ref.read(httpServiceProvider);
  LocalCalendarDatasource get localCalendar => _ref.read(localCalendarDatasourceProvider);
  LocalShiftDatasource get localShift => _ref.read(localShiftDatasourceProvider);
  LocalAuthDatasource get localAuth => _ref.read(localAuthDatasourceProvider);
  RemoteAuthDatasource get remoteAuth => _ref.read(remoteAuthDatasourceProvider);
  LocalStoreDatasource get localStore => _ref.read(localStoreDatasourceProvider);
  LocalSyncDatasource get localSync => _ref.read(localSyncDatasourceProvider);
  ProfileRepository get profileRepo => _ref.read(profileRepositoryProvider);
}
