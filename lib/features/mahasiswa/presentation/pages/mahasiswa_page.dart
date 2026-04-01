import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import 'package:dashboard_mahasiswa/features/mahasiswa/data/models/mahasiswa_model.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaProvider);
    final savedUsers = ref.watch(mahasiswaSavedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedMahasiswaSection(savedUsers: savedUsers),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: mahasiswaState.when(
              loading: () => const LoadingWidget(),
              error: (e, _) => CustomErrorWidget(
                message: e.toString(),
                onRetry: () => ref.read(mahasiswaProvider.notifier).refresh(),
              ),
              data: (list) => _MahasiswaListWithSave(mahasiswaList: list),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;

  const _SavedMahasiswaSection({required this.savedUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(mahasiswaProvider.notifier)
                              .clearSavedUsers();

                          ref.invalidate(mahasiswaSavedUsersProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Semua data dihapus'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete,
                            size: 14, color: Colors.red),
                        label: const Text(
                          'Hapus Semua',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text(
              'Gagal membaca data',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Belum ada data tersimpan',
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return ListTile(
                      dense: true,
                      title: Text(user['username'] ?? '-'),
                      subtitle: Text('ID: ${user['user_id']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          await ref
                              .read(mahasiswaProvider.notifier)
                              .removeSavedUser(user['user_id'] ?? '');

                          ref.invalidate(mahasiswaSavedUsersProvider);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MahasiswaListWithSave extends ConsumerWidget {
  final List<MahasiswaModel> mahasiswaList;

  const _MahasiswaListWithSave({required this.mahasiswaList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(mahasiswaProvider);
      },
      child: ListView.builder(
        itemCount: mahasiswaList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${mahasiswa.id}'),
              ),
              title: Text(mahasiswa.name),
              subtitle: Text('${mahasiswa.email}\n${mahasiswa.body}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await ref
                      .read(mahasiswaProvider.notifier)
                      .saveSelectedMahasiswa(mahasiswa);

                  ref.invalidate(mahasiswaSavedUsersProvider);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${mahasiswa.name} disimpan'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
