import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/shift_pattern.dart';
import '../../../calendar/domain/models/shift.dart';
import '../controllers/shift_controller.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/constants/app_constants.dart';

class ShiftConfigScreen extends ConsumerStatefulWidget {
  const ShiftConfigScreen({super.key});

  @override
  ConsumerState<ShiftConfigScreen> createState() => _ShiftConfigScreenState();
}

class _ShiftConfigScreenState extends ConsumerState<ShiftConfigScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(shiftProvider.notifier).loadConfigs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shiftProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildPatternsSection(context, state)),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePatternSheet(context),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Pattern'),
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
          Text(
            'Shift Patterns',
            style: AppTypography.displaySmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Configure your repeating shift schedules',
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1);
  }

  Widget _buildPatternsSection(BuildContext context, ShiftState state) {
    if (state.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: List.generate(3, (i) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: SkeletonLoader(height: 100, borderRadius: 16),
          )),
        ),
      );
    }

    if (state.configs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: EmptyState(
          icon: Icons.schedule_outlined,
          title: 'No shift patterns yet',
          subtitle: 'Create your first shift pattern to start scheduling',
          actionLabel: 'Create Pattern',
          onAction: () => _showCreatePatternSheet(context),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Your Patterns',
            actionLabel: state.configs.isNotEmpty ? '${state.configs.length} configs' : null,
          ),
          const SizedBox(height: 8),
          ...state.configs.map((config) => _buildConfigCard(context, config)),
        ],
      ),
    );
  }

  Widget _buildConfigCard(BuildContext context, dynamic config) {
    final theme = Theme.of(context);
    final monthName = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][config.month - 1];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$monthName ${config.year}',
                      style: AppTypography.labelLarge.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  if (config.patterns.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      '${config.patterns.length} patterns',
                      style: AppTypography.caption.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ),
          if (config.patterns.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...config.patterns.take(2).map((pattern) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  ShiftBadge(
                    type: pattern.shiftType,
                    fontSize: 12,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${pattern.consecutiveWorkDays}D / ${pattern.consecutiveOffDays}O',
                    style: AppTypography.bodySmall.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${pattern.startTime} - ${pattern.endTime}',
                    style: AppTypography.caption.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            )),
            if (config.patterns.length > 2)
              Text(
                '+${config.patterns.length - 2} more patterns',
                style: AppTypography.caption.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05);
  }

  void _showCreatePatternSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CreatePatternSheet(
        onSaved: (pattern) {
          ref.read(shiftProvider.notifier).addPattern(pattern);
        },
      ),
    );
  }
}

class _CreatePatternSheet extends StatefulWidget {
  final Function(ShiftPattern) onSaved;

  const _CreatePatternSheet({required this.onSaved});

  @override
  State<_CreatePatternSheet> createState() => _CreatePatternSheetState();
}

class _CreatePatternSheetState extends State<_CreatePatternSheet> {
  ShiftTypeEnum _selectedType = ShiftTypeEnum.morning;
  int _workDays = 5;
  int _offDays = 2;
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 16, minute: 0);
  String _name = '';

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
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Create Shift Pattern', style: AppTypography.titleLarge),
                const SizedBox(height: 24),

                Text('Pattern Name', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(hintText: 'e.g. Standard Week'),
                  onChanged: (v) => _name = v,
                ),
                const SizedBox(height: 20),

                Text('Shift Type', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ShiftTypeEnum.values.where((t) => t != ShiftTypeEnum.off).map((type) {
                    final isSelected = _selectedType == type;
                    return ChoiceChip(
                      label: Text(type.name[0].toUpperCase() + type.name.substring(1)),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedType = type),
                      selectedColor: theme.colorScheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Work Days', style: AppTypography.labelLarge),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.dividerColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_rounded, size: 18),
                                  onPressed: _workDays > 1 ? () => setState(() => _workDays--) : null,
                                ),
                                Text('$_workDays', style: AppTypography.titleMedium),
                                IconButton(
                                  icon: const Icon(Icons.add_rounded, size: 18),
                                  onPressed: _workDays < 14 ? () => setState(() => _workDays++) : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Off Days', style: AppTypography.labelLarge),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.dividerColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_rounded, size: 18),
                                  onPressed: _offDays > 1 ? () => setState(() => _offDays--) : null,
                                ),
                                Text('$_offDays', style: AppTypography.titleMedium),
                                IconButton(
                                  icon: const Icon(Icons.add_rounded, size: 18),
                                  onPressed: _offDays < 7 ? () => setState(() => _offDays++) : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start Time', style: AppTypography.labelLarge),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              final time = await showTimePicker(context: context, initialTime: _startTime);
                              if (time != null) setState(() => _startTime = time);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(_startTime.format(context)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End Time', style: AppTypography.labelLarge),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              final time = await showTimePicker(context: context, initialTime: _endTime);
                              if (time != null) setState(() => _endTime = time);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(_endTime.format(context)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _savePattern,
                    child: const Text('Create Pattern'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  void _savePattern() {
    final pattern = ShiftPattern(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _name.isEmpty ? '${_selectedType.name} Pattern' : _name,
      shiftType: _selectedType,
      consecutiveWorkDays: _workDays,
      consecutiveOffDays: _offDays,
      startTime: _startTime.format(context),
      endTime: _endTime.format(context),
      startDate: DateTime.now(),
      createdAt: DateTime.now(),
    );
    widget.onSaved(pattern);
    Navigator.pop(context);
  }
}
