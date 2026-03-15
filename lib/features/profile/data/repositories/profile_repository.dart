import 'package:dashboard_mahasiswa/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  Future<List<ProfileModel>> getProfileList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ProfileModel(
        nama: 'Hanif Azzam',
        nim: '200411100011',
        tahunLulus: '2024',
        pekerjaan: 'Mobile Developer',
        instansi: 'PT Solusi Nusantara',
      ),
      ProfileModel(
        nama: 'Risa Anggraini',
        nim: '200411100024',
        tahunLulus: '2024',
        pekerjaan: 'Data Analyst',
        instansi: 'Badan Riset Daerah',
      ),
      ProfileModel(
        nama: 'Bagas Mahendra',
        nim: '190411100032',
        tahunLulus: '2023',
        pekerjaan: 'Backend Engineer',
        instansi: 'PT Integrasi Digital',
      ),
      ProfileModel(
        nama: 'Dewi Lestari',
        nim: '190411100041',
        tahunLulus: '2023',
        pekerjaan: 'UI Engineer',
        instansi: 'Studio Kreasi Produk',
      ),
    ];
  }
}
