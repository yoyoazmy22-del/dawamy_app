import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/subscription.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../sync/domain/repositories/sync_repository.dart';
import '../../../sync/data/repositories/sync_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';

class ProfileState {
  final Subscription subscription;
  final String themeMode;
  final DateTime? lastSyncTime;
  final bool isExporting;
  final bool isLoading;

  const ProfileState({
    this.subscription = const Subscription(tier: SubscriptionTier.free, isActive: true),
    this.themeMode = 'system',
    this.lastSyncTime,
    this.isExporting = false,
    this.isLoading = false,
  });

  ProfileState copyWith({
    Subscription? subscription,
    String? themeMode,
    DateTime? lastSyncTime,
    bool? isExporting,
    bool? isLoading,
  }) {
    return ProfileState(
      subscription: subscription ?? this.subscription,
      themeMode: themeMode ?? this.themeMode,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      isExporting: isExporting ?? this.isExporting,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final AuthRepository _authRepository;
  final SyncRepository _syncRepository;
  final ProfileRepository _profileRepository;

  ProfileNotifier(this._authRepository, this._syncRepository, this._profileRepository)
      : super(const ProfileState());

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final themeMode = await _profileRepository.getThemeMode();
      final lastSync = await _syncRepository.getLastSyncTime();
      final user = await _authRepository.getCurrentUser();
      state = state.copyWith(
        themeMode: themeMode,
        lastSyncTime: lastSync,
        subscription: user?.subscriptionPlan == 'pro'
            ? const Subscription(tier: SubscriptionTier.pro, isActive: true)
            : Subscription.free,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> setThemeMode(String mode) async {
    await _profileRepository.setThemeMode(mode);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> upgradeToPro() async {
    state = state.copyWith(
      subscription: const Subscription(tier: SubscriptionTier.pro, isActive: true),
    );
  }

  Future<void> syncNow() async {
    final success = await _syncRepository.syncAll();
    if (success) {
      state = state.copyWith(lastSyncTime: DateTime.now());
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
    ref.read(authRepositoryProvider),
    ref.read(syncRepositoryProvider),
    ref.read(profileRepositoryProvider),
  );
});
