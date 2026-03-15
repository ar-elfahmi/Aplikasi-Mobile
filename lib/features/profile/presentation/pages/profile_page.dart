import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mahasiswa Lulus')),
      body: const Center(
        child: Text(
          'Halaman ringkasan mahasiswa lulus',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
