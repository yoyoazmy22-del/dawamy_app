import 'package:flutter/material.dart';
import '../../domain/models/store_data.dart';
import '../../../../core/theme/typography.dart';

class StoreLinkCard extends StatelessWidget {
  final StoreLink storeLink;
  final VoidCallback onOpen;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const StoreLinkCard({
    super.key,
    required this.storeLink,
    required this.onOpen,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.store_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeLink.name ?? 'My Store',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      storeLink.url,
                      style: AppTypography.caption.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                onSelected: (v) {
                  if (v == 'edit') onEdit();
                  if (v == 'remove') onRemove();
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'remove', child: Text('Remove')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: const Text('Open Store'),
            ),
          ),
        ],
      ),
    );
  }
}
