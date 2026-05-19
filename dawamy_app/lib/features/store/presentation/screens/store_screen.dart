import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/store_controller.dart';
import '../widgets/store_link_card.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/constants/app_constants.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(storeProvider.notifier).loadStoreLink();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(
              child: state.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(AppConstants.defaultPadding),
                      child: SkeletonLoader(height: 200, borderRadius: 16),
                    )
                  : state.storeLink != null
                      ? _buildStoreContent(context, state)
                      : _buildEmptyState(context),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
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
        AppConstants.defaultPadding,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Store', style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: 4),
          Text(
            'Link your online store or shop',
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1);
  }

  Widget _buildStoreContent(BuildContext context, StoreState state) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          StoreLinkCard(
            storeLink: state.storeLink!,
            onOpen: () => _openStore(state.storeLink!.url),
            onEdit: () => _showAddLinkSheet(context),
            onRemove: () {
              ref.read(storeProvider.notifier).removeStoreLink();
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: EmptyState(
        icon: Icons.store_outlined,
        title: 'No store linked',
        subtitle: 'Add your store URL to access it easily',
        actionLabel: 'Add Store Link',
        onAction: () => _showAddLinkSheet(context),
      ),
    );
  }

  void _showAddLinkSheet(BuildContext context) {
    final controller = TextEditingController();
    final nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )),
                  const SizedBox(height: 24),
                  Text('Link Your Store', style: AppTypography.titleLarge),
                  const SizedBox(height: 24),
                  Text('Store Name (optional)', style: AppTypography.labelLarge),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'e.g. My Shop'),
                  ),
                  const SizedBox(height: 16),
                  Text('Store URL', style: AppTypography.labelLarge),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'https://example.com/store',
                      prefixText: '  ',
                    ),
                    keyboardType: TextInputType.url,
                    autofocus: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          final url = controller.text.startsWith('http')
                              ? controller.text
                              : 'https://${controller.text}';
                          ref.read(storeProvider.notifier).saveStoreLink(
                            url,
                            name: nameController.text.isNotEmpty
                                ? nameController.text
                                : null,
                          );
                          Navigator.pop(ctx);
                        }
                      },
                      child: const Text('Save Link'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openStore(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
