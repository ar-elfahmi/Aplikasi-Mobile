import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(mahasiswaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mahasiswa')),

      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final m = list[i];
              return ListTile(
                title: Text(m.name),
                subtitle: Text(m.email),
              );
            },
          );
        },
      ),
    );
  }
}