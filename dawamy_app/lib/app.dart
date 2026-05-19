import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/animated_bottom_nav.dart';
import 'features/calendar/presentation/screens/calendar_screen.dart';
import 'features/shifts/presentation/screens/shift_config_screen.dart';
import 'features/store/presentation/screens/store_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'core/constants/app_constants.dart';

class DawamyApp extends StatelessWidget {
  const DawamyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      home: AppShell(),
    );
  }
}

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  final _pages = const [
    CalendarScreen(),
    ShiftConfigScreen(),
    StoreScreen(),
    ProfileScreen(),
  ];

  final _navItems = const [
    BottomNavItem(icon: Icons.calendar_month_outlined, activeIcon: Icons.calendar_month_rounded, label: 'Calendar'),
    BottomNavItem(icon: Icons.schedule_outlined, activeIcon: Icons.schedule_rounded, label: 'Shifts'),
    BottomNavItem(icon: Icons.store_outlined, activeIcon: Icons.store_rounded, label: 'Store'),
    BottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: 300.ms);
    ref.read(authProvider.notifier).checkAuth();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final brightness = Theme.of(context).brightness;
    final themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

    if (!authState.isAuthenticated && !authState.isLoading) {
      return Theme(data: AppTheme.fromMode(themeMode), child: const LoginScreen());
    }

    return Theme(
      data: AppTheme.fromMode(themeMode),
      child: Scaffold(
        extendBody: true,
        body: AnimatedSwitcher(
          duration: 300.ms,
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: KeyedSubtree(key: ValueKey(_currentIndex), child: _pages[_currentIndex]),
        ),
        bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: _navItems,
        ),
      ),
    );
  }
}
