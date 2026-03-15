import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  /// mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    /// simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    /// data dummy
    return [
      DosenModel(
        nama: 'Anank Prasetyo',
        nip: '123456789',
        email: 'anank.prasetyo@example.com',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Rachman Sinatriya',
        nip: '987654321',
        email: 'rachman.sinatriya@example.com',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Alfian Sukma',
        nip: '456789123',
        email: 'alfian.sukma@example.com',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }
}
