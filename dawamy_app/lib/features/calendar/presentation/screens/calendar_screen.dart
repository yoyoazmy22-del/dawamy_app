import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/calendar_controller.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/month_header.dart';
import '../widgets/stats_cards.dart';
import '../widgets/day_detail_sheet.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/constants/app_constants.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(calendarProvider.notifier).loadMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(calendarProvider.notifier).loadMonth();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context, state)),
              SliverToBoxAdapter(child: _buildStatsSection(context, state)),
              SliverToBoxAdapter(child: _buildCalendarSection(context, state)),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CalendarState state) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calendar',
                style: AppTypography.displayMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.date_range_rounded,
                    size: 14, color: cs.onSurface.withOpacity(0.4)),
                  const SizedBox(width: 4),
                  Text(
                    'Manage your shifts',
                    style: AppTypography.bodyMedium.copyWith(
                      color: cs.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cs.primary.withOpacity(0.12),
                  cs.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: cs.primary.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: (state.monthData?.totalOvertimeHours ?? 0) > 0
                        ? const Color(0xFF00B894)
                        : const Color(0xFFFDCB6E),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ((state.monthData?.totalOvertimeHours ?? 0) > 0
                            ? const Color(0xFF00B894)
                            : const Color(0xFFFDCB6E)).withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  state.monthData != null
                      ? '${state.monthData!.workDays}D / ${state.monthData!.offDays}O'
                      : 'Free Plan',
                  style: AppTypography.labelMedium.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1);
  }

  Widget _buildStatsSection(BuildContext context, CalendarState state) {
    if (state.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: List.generate(3, (i) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
              child: const SkeletonLoader(height: 80, borderRadius: 16),
            ),
          )),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        0,
      ),
      child: StatsCards(monthData: state.monthData),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildCalendarSection(BuildContext context, CalendarState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        AppConstants.defaultPadding,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AppConstants.largeRadius),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              MonthHeader(
                currentMonth: state.currentMonth,
                onPrevious: () => ref.read(calendarProvider.notifier).goToPreviousMonth(),
                onNext: () => ref.read(calendarProvider.notifier).goToNextMonth(),
                onToday: () => ref.read(calendarProvider.notifier).goToToday(),
              ),
              const SizedBox(height: 16),
              if (state.isLoading)
                const SkeletonCalendar()
              else
                CalendarGrid(
                  monthData: state.monthData,
                  currentMonth: state.currentMonth,
                  onDayTap: (day) {
                    ref.read(calendarProvider.notifier).selectDay(day);
                    _showDayDetailSheet(context, day);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDayDetailSheet(BuildContext context, dynamic day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DayDetailSheet(dayData: day),
    );
  }

  ThemeData get theme => Theme.of(context);
}
