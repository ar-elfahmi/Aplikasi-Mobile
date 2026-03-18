import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif (Posts API)'),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(mahasiswaAktifProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => CustomErrorWidget(
          message: e.toString(),
          onRetry: () => ref.read(mahasiswaAktifProvider.notifier).refresh(),
        ),
        data: (list) => MahasiswaAktifListView(
          mahasiswaAktifList: list,
          onRefresh: () => ref.read(mahasiswaAktifProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
