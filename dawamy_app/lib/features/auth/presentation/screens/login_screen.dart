import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/constants/app_constants.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('D', style: TextStyle(
                      color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'Inter',
                    )),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Welcome back', style: AppTypography.displaySmall.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Sign in to continue with Dawamy', style: AppTypography.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                )),
                const SizedBox(height: 40),
                Text('Email', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined, size: 18),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text('Password', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outlined, size: 18),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : _login,
                    child: state.isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 16),
                if (state.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE17055).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Color(0xFFE17055), size: 16),
                        const SizedBox(width: 8),
                        Expanded(child: Text(state.error!, style: const TextStyle(color: Color(0xFFE17055), fontSize: 13))),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: AppTypography.bodyMedium.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }
}
