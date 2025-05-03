import 'package:absensi/pages/jadwalpembelajaran/jadwal_pembelajaran.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/auth/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/siswa/siswa_page.dart';
import 'pages/guru/guru_page.dart';
import 'pages/jadwal/jadwal_pembelajaran.dart';
import 'pages/absensi/absensi_list_page.dart';
import 'providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(  // Wrap the app with ProviderScope for Riverpod
      child: MaterialApp.router(
        title: 'My School App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: _router,
      ),
    );
  }

  // GoRouter Configuration
  final GoRouter _router = GoRouter(
    initialLocation: '/login',  // Set initial route to login
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      // Home Routes (protected routes)
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
        redirect: (context, state) {
          // Access authProvider from Riverpod using ref.read(authProvider)
          final user = context.read(authProvider).value;
          if (user == null) {
            return '/login'; // Redirect to login if not authenticated
          }
          return null;
        },
      ),
      // Siswa Routes
      GoRoute(
        path: '/siswa',
        builder: (context, state) => const SiswaPage(),
      ),
      // Guru Routes
      GoRoute(
        path: '/guru',
        builder: (context, state) => const GuruPage(),
      ),
      // Jadwal Routes
      GoRoute(
        path: '/jadwal',
        builder: (context, state) => const JadwalPage(),
      ),
      // Absensi Routes
      GoRoute(
        path: '/absensi',
        builder: (context, state) => const AbsensiListPage(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page Not Found')),
      );
    },
  );
}
