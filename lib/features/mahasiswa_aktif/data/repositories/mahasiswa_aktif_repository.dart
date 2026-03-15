import 'package:dashboard_mahasiswa/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Cahya Pratama',
        nim: '210411100102',
        semester: 8,
        ipk: 3.74,
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Siti Rahmawati',
        nim: '220411100033',
        semester: 6,
        ipk: 3.62,
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Rendi Saputra',
        nim: '230411100045',
        semester: 4,
        ipk: 3.48,
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Mira Oktaviani',
        nim: '240411100009',
        semester: 2,
        ipk: 3.90,
        statusAkademik: 'Aktif Prestasi',
      ),
    ];
  }
}
