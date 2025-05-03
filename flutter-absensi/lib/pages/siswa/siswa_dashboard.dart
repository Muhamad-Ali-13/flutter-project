import 'package:flutter/material.dart';

class SiswaDashboard extends StatelessWidget {
  const SiswaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siswa Dashboard')),
      body: const Center(
        child: Text('Siswa Dashboard'),
      ),
    );
  }
}
