import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider =
    Provider((ref) => MahasiswaRepository());

class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {

  final MahasiswaRepository _repo;

  MahasiswaNotifier(this._repo)
      : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      final data = await _repo.getMahasiswa();
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final mahasiswaProvider = StateNotifierProvider<
    MahasiswaNotifier,
    AsyncValue<List<MahasiswaModel>>>((ref) {

  final repo = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repo);

});