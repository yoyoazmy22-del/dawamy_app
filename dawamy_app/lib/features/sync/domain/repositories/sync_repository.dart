abstract class SyncRepository {
  Future<bool> syncAll();
  Future<DateTime?> getLastSyncTime();
  Future<bool> hasPendingSync();
  Future<void> markSynced();
  Future<bool> testConnection();
}
