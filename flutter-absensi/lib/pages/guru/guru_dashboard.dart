import 'package:flutter/material.dart';

class GuruDashboard extends StatelessWidget {
  const GuruDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guru Dashboard')),
      body: const Center(
        child: Text('Guru Dashboard'),
      ),
    );
  }
}
