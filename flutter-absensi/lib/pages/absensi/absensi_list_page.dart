import 'package:flutter/material.dart';

class AbsensiListPage extends StatelessWidget {
  const AbsensiListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Siswa')),
      body: ListView.builder(
        itemCount: 20, // Replace with actual data
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Absensi Siswa ${index + 1}'),
            subtitle: Text('Tanggal: ${index + 1} May 2025'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
