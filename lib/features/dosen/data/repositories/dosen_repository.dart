import 'package:dio/dio.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = Dio();

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      final List data = response.data;

      return data.map((e) => DosenModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data dosen: $e');
    }
  }
}
