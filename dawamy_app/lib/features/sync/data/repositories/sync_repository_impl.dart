import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/sync_repository.dart';
import '../datasources/local_sync_datasource.dart';
import '../datasources/remote_sync_datasource.dart';
import '../../../../services/http_service.dart';

class SyncRepositoryImpl implements SyncRepository {
  final LocalSyncDatasource _local;
  final RemoteSyncDatasource _remote;
  final HttpService _http;

  SyncRepositoryImpl(this._local, this._remote, this._http);

  @override
  Future<bool> syncAll() async {
    try {
      final success = await _remote.syncAll();
      if (success) {
        await _local.saveLastSyncTime(DateTime.now());
        await _local.clearPendingSync();
      }
      return success;
    } catch (_) {
      await _local.markPendingSync();
      return false;
    }
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    return _local.getLastSyncTime();
  }

  @override
  Future<bool> hasPendingSync() async {
    return _local.hasPendingSync();
  }

  @override
  Future<void> markSynced() async {
    await _local.saveLastSyncTime(DateTime.now());
    await _local.clearPendingSync();
  }

  @override
  Future<bool> testConnection() async {
    return _http.testConnection();
  }
}

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final local = ref.read(localSyncDatasourceProvider);
  final remote = RemoteSyncDatasource(ref.read(httpServiceProvider));
  final http = ref.read(httpServiceProvider);
  return SyncRepositoryImpl(local, remote, http);
});
