import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/jadwal.dart';
import '../api/jadwal_api.dart';

final jadwalProvider = StateNotifierProvider<JadwalNotifier, AsyncValue<List<Jadwal>>>((ref) {
  return JadwalNotifier(ref.read);
});

class JadwalNotifier extends StateNotifier<AsyncValue<List<Jadwal>>> {
  final Reader _read;

  JadwalNotifier(this._read) : super(const AsyncValue.loading());

  Future<void> getAllJadwal() async {
    try {
      state = const AsyncValue.loading();
      final jadwalList = await JadwalApi.getAllJadwal();
      state = AsyncValue.data(jadwalList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
