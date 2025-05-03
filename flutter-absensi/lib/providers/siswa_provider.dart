import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/siswa.dart';
import '../api/siswa_api.dart';

final siswaProvider = StateNotifierProvider<SiswaNotifier, AsyncValue<List<Siswa>>>((ref) {
  return SiswaNotifier(ref.read);
});

class SiswaNotifier extends StateNotifier<AsyncValue<List<Siswa>>> {
  final Reader _read;

  SiswaNotifier(this._read) : super(const AsyncValue.loading());

  Future<void> getAllSiswa() async {
    try {
      state = const AsyncValue.loading();
      final siswaList = await SiswaApi.getAllSiswa();
      state = AsyncValue.data(siswaList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
