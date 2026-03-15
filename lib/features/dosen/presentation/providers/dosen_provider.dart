import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/repositories/dosen_repository.dart';

/// repository provider
final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  return DosenRepository();
});

/// notifier
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  /// load data dosen
  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();

    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// refresh data
  Future<void> refresh() async {
    await loadDosenList();
  }
}

/// provider
final dosenNotifierProvider = StateNotifierProvider.autoDispose<DosenNotifier,
    AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return DosenNotifier(repository);
});
