import 'package:dashboard_mahasiswa/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Alya Nuraini',
        nim: '220411100001',
        kelas: 'D4TI 4A',
        angkatan: '2022',
        email: 'alya.nuraini@example.com',
      ),
      MahasiswaModel(
        nama: 'Fikri Maulana',
        nim: '220411100014',
        kelas: 'D4TI 4A',
        angkatan: '2022',
        email: 'fikri.maulana@example.com',
      ),
      MahasiswaModel(
        nama: 'Nabila Zahra',
        nim: '230411100021',
        kelas: 'D4TI 3B',
        angkatan: '2023',
        email: 'nabila.zahra@example.com',
      ),
      MahasiswaModel(
        nama: 'Dimas Ramadhan',
        nim: '230411100030',
        kelas: 'D4TI 3B',
        angkatan: '2023',
        email: 'dimas.ramadhan@example.com',
      ),
    ];
  }
}
