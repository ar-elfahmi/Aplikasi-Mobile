import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/services/local_storage_service.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider((ref) => MahasiswaRepository());

final mahasiswaLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final mahasiswaSavedUsersProvider =
    FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(mahasiswaLocalStorageProvider);
  return storage.getSavedUsers();
});

class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repo;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repo, this._storage)
      : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();

    try {
      final data = await _repo.getMahasiswa();
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> refresh() async {
    await load();
  }

  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await _storage.addUserToSavedList(
      userId: mahasiswa.id.toString(),
      username: mahasiswa.name,
    );
  }

  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

final mahasiswaProvider =
    StateNotifierProvider<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>(
        (ref) {
  final repo = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(mahasiswaLocalStorageProvider);
  return MahasiswaNotifier(repo, storage);
});
