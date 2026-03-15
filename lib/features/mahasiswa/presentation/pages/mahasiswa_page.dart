import 'package:flutter/material.dart';

class MahasiswaPage extends StatelessWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total Mahasiswa')),
      body: const Center(
        child: Text(
          'Halaman total mahasiswa',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
