// lib/pages/absensi/absensi_form_page.dart

import 'package:flutter/material.dart';
import '../../api/absensi_api.dart';
import '../../models/absensi.dart';

class AbsensiFormPage extends StatefulWidget {
  const AbsensiFormPage({Key? key}) : super(key: key);

  @override
  _AbsensiFormPageState createState() => _AbsensiFormPageState();
}

class _AbsensiFormPageState extends State<AbsensiFormPage> {
  final _jamMasukController = TextEditingController();
  final _jamKeluarController = TextEditingController();
  final _statusController = TextEditingController();
  final _fotoAbsensiController = TextEditingController();

  Future<void> _submit() async {
    final absensiData = Absensi(
      id: 0, // ID akan dihandle oleh backend
      idSiswa: 1,  // Misalnya, ini ID siswa yang login
      idJadwal: 1, // ID jadwal pembelajaran
      tanggal: DateTime.now(),
      jamMasuk: _jamMasukController.text,
      jamKeluar: _jamKeluarController.text,
      status: _statusController.text,
      fotoAbsensi: _fotoAbsensiController.text,
    );

    // Memanggil fungsi addAbsensi dengan data dalam bentuk JSON
    await AbsensiApi.addAbsensi(absensiData.toJson());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Absensi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _jamMasukController,
              decoration: const InputDecoration(labelText: 'Jam Masuk'),
            ),
            TextField(
              controller: _jamKeluarController,
              decoration: const InputDecoration(labelText: 'Jam Keluar'),
            ),
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: _fotoAbsensiController,
              decoration: const InputDecoration(labelText: 'Foto Absensi'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}


