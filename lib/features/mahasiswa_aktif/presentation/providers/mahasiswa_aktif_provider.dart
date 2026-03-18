import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_aktif_model.dart';
import '../../data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepoProvider =
    Provider((ref) => MahasiswaAktifRepository());

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repo;

  MahasiswaAktifNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();

    try {
      final data = await _repo.getData();
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> refresh() async {
    await load();
  }
}

final mahasiswaAktifProvider = StateNotifierProvider<MahasiswaAktifNotifier,
    AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repo = ref.watch(mahasiswaAktifRepoProvider);
  return MahasiswaAktifNotifier(repo);
});
