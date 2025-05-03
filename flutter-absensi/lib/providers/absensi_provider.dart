import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/absensi.dart';
import '../api/absensi_api.dart';

final absensiProvider = StateNotifierProvider<AbsensiNotifier, AsyncValue<List<Absensi>>>((ref) {
  return AbsensiNotifier(ref.read);
});

class AbsensiNotifier extends StateNotifier<AsyncValue<List<Absensi>>> {
  final Reader _read;

  AbsensiNotifier(this._read) : super(const AsyncValue.loading());

  Future<void> getAllAbsensi() async {
    try {
      state = const AsyncValue.loading();
      final absensiList = await AbsensiApi.getAllAbsensi();
      state = AsyncValue.data(absensiList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addAbsensi(Absensi absensi) async {
    try {
      state = const AsyncValue.loading();
      await AbsensiApi.addAbsensi(absensi);
      state = const AsyncValue.data([]);
      // Optionally fetch all absensi after adding
      await getAllAbsensi();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
