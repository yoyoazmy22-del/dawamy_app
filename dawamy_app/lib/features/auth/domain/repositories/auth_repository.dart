import 'package:dawamy/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signIn(String email, String password);
  Future<AppUser> register(String email, String password, String username);
  Future<void> signOut();
  Future<void> updateProfile(AppUser user);
  Future<bool> isSignedIn();
  Stream<AppUser?> authStateChanges();
}
