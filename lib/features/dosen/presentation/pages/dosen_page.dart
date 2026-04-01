import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';
import 'package:dashboard_mahasiswa/features/dosen/presentation/providers/dosen_provider.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(dosenNotifierProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedUserSection(savedUsers: savedUsers),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Dosen',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: dosenState.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: 'Gagal memuat data dosen: ${error.toString()}',
                onRetry: () {
                  ref.read(dosenNotifierProvider.notifier).refresh();
                },
              ),
              data: (dosenList) => _DosenListWithSave(dosenList: dosenList),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SAVED USER SECTION =================

class _SavedUserSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;

  const _SavedUserSection({required this.savedUsers});

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
                              .read(dosenNotifierProvider.notifier)
                              .clearSavedUsers();

                          ref.invalidate(savedUsersProvider);

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
                              .read(dosenNotifierProvider.notifier)
                              .removeSavedUser(user['user_id'] ?? '');

                          ref.invalidate(savedUsersProvider);
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

/// ================= LIST DOSEN =================

class _DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;

  const _DosenListWithSave({required this.dosenList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(dosenNotifierProvider);
      },
      child: ListView.builder(
        itemCount: dosenList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final dosen = dosenList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${dosen.id}'),
              ),
              title: Text(dosen.name),
              subtitle: Text(
                '${dosen.username} • ${dosen.email}\n${dosen.address.city}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await ref
                      .read(dosenNotifierProvider.notifier)
                      .saveSelectedDosen(dosen);

                  ref.invalidate(savedUsersProvider);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${dosen.username} disimpan'),
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
