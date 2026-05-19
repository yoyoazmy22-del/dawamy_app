import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user.dart';
import '../../../../core/errors/failures.dart';

class RemoteAuthDatasource {
  final fb.FirebaseAuth _auth;

  RemoteAuthDatasource(this._auth);

  Future<AppUser> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUser(result.user!);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapAuthError(e));
    }
  }

  Future<AppUser> register(String email, String password, String username) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(username);
      return _mapFirebaseUser(result.user!);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapAuthError(e));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return _mapFirebaseUser(user);
    });
  }

  AppUser _mapFirebaseUser(fb.User user) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      username: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  String _mapAuthError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Invalid password';
      case 'email-already-in-use':
        return 'Email already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}

final remoteAuthDatasourceProvider = Provider<RemoteAuthDatasource>((ref) {
  return RemoteAuthDatasource(fb.FirebaseAuth.instance);
});
