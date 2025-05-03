import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../api/auth_api.dart';
import '../services/storage_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.read);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final Reader _read;

  AuthNotifier(this._read) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final user = await AuthApi.login(email, password);
      if (user != null) {
        await StorageService.saveUser(user as User);
        state = AsyncValue.data(user as User?);
      } else {
        state = const AsyncValue.error('Login failed', StackTrace.empty);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await StorageService.clearUser();
    state = const AsyncValue.data(null);
  }

  Future<void> checkLoggedIn() async {
    try {
      final user = await StorageService.getUser();
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
