import 'package:dashboard_mahasiswa/features/dashboard/data/models/dashboard_model.dart';

class DashboardRepository {
  // Mendapatkan data dashboard
  Future<DashboardData> getDashboardData() async {
    // simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // data dummy
    return DashboardData(
      userName: 'Admin D4TI',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '1,200',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '550',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Dosen',
          value: '65',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Mahasiswa Lulus',
          value: '120',
          subtitle: '',
        ),
      ],
    );
  }

  // refresh dashboard
  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }

  // mendapatkan stat berdasarkan title
  Future<DashboardStats?> getStatByTitle(String title) async {
    final data = await getDashboardData();

    try {
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null;
    }
  }
}
