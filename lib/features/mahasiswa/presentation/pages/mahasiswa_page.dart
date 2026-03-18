import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa (Comments API)'),
        actions: [
          IconButton(
            onPressed: () => ref.read(mahasiswaProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => CustomErrorWidget(
          message: e.toString(),
          onRetry: () => ref.read(mahasiswaProvider.notifier).refresh(),
        ),
        data: (list) => MahasiswaListView(
          mahasiswaList: list,
          onRefresh: () => ref.read(mahasiswaProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
