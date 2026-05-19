import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/store_data.dart';
import '../datasources/local_store_datasource.dart';

class StoreRepository {
  final LocalStoreDatasource _local;

  StoreRepository(this._local);

  Future<StoreLink?> getStoreLink() async => _local.getStoreLink();

  Future<void> saveStoreLink(StoreLink link) async => _local.saveStoreLink(link);

  Future<void> removeStoreLink() async => _local.removeStoreLink();
}

final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  return StoreRepository(ref.read(localStoreDatasourceProvider));
});
