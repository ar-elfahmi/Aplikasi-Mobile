import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import 'package:dashboard_mahasiswa/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:dashboard_mahasiswa/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaAktifState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa aktif: ${error.toString()}',
          onRetry: () {
            ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
          },
        ),
        data: (mahasiswaAktifList) {
          return MahasiswaAktifListView(
            mahasiswaAktifList: mahasiswaAktifList,
            onRefresh: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          );
        },
      ),
    );
  }
}
