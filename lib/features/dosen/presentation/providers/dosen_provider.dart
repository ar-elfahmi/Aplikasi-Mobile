import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/services/local_storage_service.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/repositories/dosen_repository.dart';

/// ================= REPOSITORY =================

final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  return DosenRepository();
});

/// ================= LOCAL STORAGE =================

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// ================= SAVED USERS =================

final savedUsersProvider =
    FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  return storage.getSavedUsers();
});

/// ================= CURRENT USER =================

final savedUserProvider = FutureProvider<Map<String, String?>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);

  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();

  return {
    'userId': userId,
    'username': username,
    'token': token,
  };
});

/// ================= NOTIFIER =================

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;
  final LocalStorageService _storage;

  DosenNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  /// Load data dari API
  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();

    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh data
  Future<void> refresh() async {
    await loadDosenList();
  }

  /// Simpan dosen ke local storage
  Future<void> saveSelectedDosen(DosenModel dosen) async {
    await _storage.addUserToSavedList(
      userId: dosen.id.toString(),
      username: dosen.username,
    );
  }

  /// Hapus 1 user
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  /// Hapus semua user
  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

/// ================= PROVIDER =================

final dosenNotifierProvider = StateNotifierProvider.autoDispose<DosenNotifier,
    AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);

  return DosenNotifier(repository, storage);
});
