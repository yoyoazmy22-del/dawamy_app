import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';
import '../widgets/subscription_card.dart';
import '../../domain/models/subscription.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/constants/app_constants.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(profileProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildProfileContent(context, state)),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        AppConstants.defaultPadding, 0,
      ),
      child: Text(
        'Profile',
        style: AppTypography.displaySmall.copyWith(fontWeight: FontWeight.w700),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1);
  }

  Widget _buildProfileContent(BuildContext context, ProfileState state) {
    if (state.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(children: [
          const SkeletonLoader(width: 80, height: 80, borderRadius: 40),
          const SizedBox(height: 16),
          const SkeletonLoader(width: 150, height: 20),
          const SizedBox(height: 8),
          const SkeletonLoader(width: 120, height: 14),
          const SizedBox(height: 24),
          ...List.generate(5, (i) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: SkeletonLoader(height: 56, borderRadius: 12),
          )),
        ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          ProfileHeader(
            isPro: state.subscription.isPro,
            onUpgrade: () => _showUpgradeSheet(context),
          ),
          const SizedBox(height: 24),
          SubscriptionCard(
            subscription: state.subscription,
            onUpgrade: () => _showUpgradeSheet(context),
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(context, state),
          const SizedBox(height: 24),
          _buildAppInfo(context),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildSettingsSection(BuildContext context, ProfileState state) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: state.themeMode == 'dark' ? 'Enabled' : 'Disabled',
            trailing: Switch(
              value: state.themeMode == 'dark',
              onChanged: (v) {
                ref.read(profileProvider.notifier).setThemeMode(v ? 'dark' : 'light');
              },
              activeColor: theme.colorScheme.primary,
            ),
          ),
          SettingsTile(
            icon: Icons.sync_outlined,
            title: 'Last Sync',
            subtitle: state.lastSyncTime != null
                ? timeago.format(state.lastSyncTime!)
                : 'Never',
          ),
          SettingsTile(
            icon: Icons.cloud_sync_outlined,
            title: 'Sync Now',
            subtitle: 'Manual sync',
            onTap: () => ref.read(profileProvider.notifier).syncNow(),
          ),
          SettingsTile(
            icon: Icons.file_download_outlined,
            title: 'Export Data',
            subtitle: 'Backup your information',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.logout_rounded,
            title: 'Sign Out',
            subtitle: '',
            textColor: const Color(0xFFE17055),
            onTap: () => ref.read(profileProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'DAWAMY',
          style: AppTypography.overline.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Version ${AppConstants.appVersion}',
          style: AppTypography.caption.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  void _showUpgradeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UpgradeSheet(
        onUpgrade: () {
          ref.read(profileProvider.notifier).upgradeToPro();
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _UpgradeSheet extends StatelessWidget {
  final VoidCallback onUpgrade;
  const _UpgradeSheet({required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(child: Container(width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
                const SizedBox(height: 24),
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(0.7),
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20, offset: const Offset(0, 8),
                    )],
                  ),
                  child: const Icon(Icons.star_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 20),
                Text('Upgrade to Pro', style: AppTypography.displaySmall.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Unlock the full power of Dawamy', style: AppTypography.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                )),
                const SizedBox(height: 24),
                ...PremiumFeatures.proFeatures.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.check_rounded, color: Color(0xFF00B894), size: 14),
                      ),
                      const SizedBox(width: 12),
                      Text(feature, style: AppTypography.bodyMedium),
                    ],
                  ),
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: onUpgrade, child: const Text('Upgrade Now')),
                ),
                const SizedBox(height: 8),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Maybe later')),
              ],
            ),
          );
        },
      ),
    );
  }
}
