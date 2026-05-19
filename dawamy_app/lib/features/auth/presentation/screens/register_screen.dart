import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/constants/app_constants.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
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
                    boxShadow: [BoxShadow(color: theme.colorScheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
                  ),
                  child: const Center(child: Text('D', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
                ),
                const SizedBox(height: 32),
                Text('Create Account', style: AppTypography.displaySmall.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Join Dawamy and manage your shifts', style: AppTypography.bodyMedium.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                const SizedBox(height: 40),
                Text('Username', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Choose a username', prefixIcon: Icon(Icons.person_outline, size: 18)),
                  validator: (v) => (v == null || v.isEmpty) ? 'Username is required' : null,
                ),
                const SizedBox(height: 16),
                Text('Email', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Enter your email', prefixIcon: Icon(Icons.email_outlined, size: 18)),
                  validator: (v) => (v == null || v.isEmpty) ? 'Email is required' : null,
                ),
                const SizedBox(height: 16),
                Text('Password', style: AppTypography.labelLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    prefixIcon: const Icon(Icons.lock_outlined, size: 18),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : _register,
                    child: state.isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Create Account'),
                  ),
                ),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFE17055).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Color(0xFFE17055), size: 16),
                          const SizedBox(width: 8),
                          Expanded(child: Text(state.error!, style: const TextStyle(color: Color(0xFFE17055), fontSize: 13))),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: AppTypography.bodyMedium.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Sign In'),
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

  void _register() {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).register(
        _emailController.text.trim(),
        _passwordController.text,
        _usernameController.text.trim(),
      );
    }
  }
}
