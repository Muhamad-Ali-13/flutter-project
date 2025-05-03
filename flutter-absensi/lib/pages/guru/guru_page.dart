import 'package:flutter/material.dart';

class GuruPage extends StatelessWidget {
  const GuruPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Guru')),
      body: ListView.builder(
        itemCount: 20, // Replace with actual data
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Guru ${index + 1}'),
            subtitle: Text('ID Guru: ${index + 1}'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
