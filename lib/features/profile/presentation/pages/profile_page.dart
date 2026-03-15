import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/common_widgets.dart';
import 'package:dashboard_mahasiswa/features/profile/presentation/providers/profile_provider.dart';
import 'package:dashboard_mahasiswa/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Lulusan'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(profileNotifierProvider);
            },
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: profileState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat profil lulusan: ${error.toString()}',
          onRetry: () {
            ref.read(profileNotifierProvider.notifier).refresh();
          },
        ),
        data: (profileList) {
          return ProfileListView(
            profileList: profileList,
            onRefresh: () {
              ref.invalidate(profileNotifierProvider);
            },
          );
        },
      ),
    );
  }
}
