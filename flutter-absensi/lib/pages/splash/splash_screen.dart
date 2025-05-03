import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../auth/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await ref.read(authProvider.notifier).checkLoggedIn();
    final user = ref.read(authProvider).value;

    if (user != null) {
      // Redirect berdasarkan role
      if (user.role == 'admin') {
        context.go('/admin_dashboard');
      } else if (user.role == 'guru') {
        context.go('/guru_dashboard');
      } else if (user.role == 'siswa') {
        context.go('/siswa_dashboard');
      }
    } else {
      // Jika belum login, ke halaman login
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Memuat...'),
          ],
        ),
      ),
    );
  }
}
