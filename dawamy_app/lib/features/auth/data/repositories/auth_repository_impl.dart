import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/models/user.dart';
import '../datasources/local_auth_datasource.dart';
import '../datasources/remote_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalAuthDatasource _local;
  final RemoteAuthDatasource _remote;

  AuthRepositoryImpl(this._local, this._remote);

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final remote = await _remote.getCurrentUser();
      if (remote != null) {
        await _local.saveUser(remote);
        return remote;
      }
    } catch (_) {}
    return _local.getUser();
  }

  @override
  Future<AppUser> signIn(String email, String password) async {
    final user = await _remote.signIn(email, password);
    await _local.saveUser(user);
    return user;
  }

  @override
  Future<AppUser> register(String email, String password, String username) async {
    final user = await _remote.register(email, password, username);
    await _local.saveUser(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    try {
      await _remote.signOut();
    } catch (_) {}
    await _local.clearUser();
  }

  @override
  Future<void> updateProfile(AppUser user) async {
    await _local.saveUser(user);
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final remote = await _remote.getCurrentUser();
      if (remote != null) return true;
    } catch (_) {}
    return _local.hasUser();
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return _remote.authStateChanges();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final local = ref.read(localAuthDatasourceProvider);
  final remote = ref.read(remoteAuthDatasourceProvider);
  return AuthRepositoryImpl(local, remote);
});
