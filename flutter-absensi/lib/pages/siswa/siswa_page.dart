import 'package:flutter/material.dart';

class SiswaPage extends StatelessWidget {
  const SiswaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Siswa')),
      body: ListView.builder(
        itemCount: 20, // Replace with actual data
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Siswa ${index + 1}'),
            subtitle: Text('ID Siswa: ${index + 1}'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
