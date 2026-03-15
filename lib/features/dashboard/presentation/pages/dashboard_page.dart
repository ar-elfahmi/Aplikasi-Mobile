import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      // ✅ FIX: Tambahkan AppBar agar tampilan tidak kosong di atas
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          // Tombol toggle theme
          Consumer(
            builder: (context, ref, _) {
              final isDark = ref.watch(themeModeProvider);
              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state = !isDark;
                },
              );
            },
          ),
        ],
      ),
      body: dashboardState.when(
        // State: Loading
        loading: () => const LoadingWidget(),

        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () {
            ref.read(dashboardNotifierProvider.notifier).refresh();
          },
        ),

        // State: Data berhasil dimuat
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(dashboardNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: DashboardHeader(userName: dashboardData.userName),
                ),

                // Stats Section
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Statistik',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppConstants.paddingMedium,
                            mainAxisSpacing: AppConstants.paddingMedium,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            return StatCard(
                              stats: dashboardData.stats[index],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                ref
                                    .read(selectedStatIndexProvider.notifier)
                                    .state = index;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // ✅ FIX: Padding bawah agar konten tidak tertutup FAB
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Refresh Data',
        onPressed: () {
          ref.read(dashboardNotifierProvider.notifier).refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Memperbarui data...'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
