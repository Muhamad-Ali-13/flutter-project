import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/guru.dart';
import '../api/guru_api.dart';

final guruProvider = StateNotifierProvider<GuruNotifier, AsyncValue<List<Guru>>>((ref) {
  return GuruNotifier(ref.read);
});

class GuruNotifier extends StateNotifier<AsyncValue<List<Guru>>> {
  final Reader _read;

  GuruNotifier(this._read) : super(const AsyncValue.loading());

  Future<void> getAllGuru() async {
    try {
      state = const AsyncValue.loading();
      final guruList = await GuruApi.getAllGuru();
      state = AsyncValue.data(guruList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
