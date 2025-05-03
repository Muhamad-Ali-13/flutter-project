import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Pembelajaran')),
      body: ListView.builder(
        itemCount: 5, // Replace with actual data
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Mata Pelajaran ${index + 1}'),
            subtitle: Text('ID Jadwal: ${index + 1}'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
