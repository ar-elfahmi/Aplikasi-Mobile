import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  static const String _endpoint =
      'https://jsonplaceholder.typicode.com/comments';

  final Dio _dio;
  final http.Client _httpClient;

  MahasiswaRepository({Dio? dio, http.Client? httpClient})
      : _dio = dio ?? Dio(),
        _httpClient = httpClient ?? http.Client();

  Future<List<MahasiswaModel>> getMahasiswa() async {
    try {
      return await _getMahasiswaWithHttp();
    } catch (_) {
      return _getMahasiswaWithDio();
    }
  }

  Future<List<MahasiswaModel>> _getMahasiswaWithHttp() async {
    final response = await _httpClient.get(Uri.parse(_endpoint));
    if (response.statusCode != 200) {
      throw Exception('HTTP error: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => MahasiswaModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<MahasiswaModel>> _getMahasiswaWithDio() async {
    final response = await _dio.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Dio error: ${response.statusCode}');
    }

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((e) => MahasiswaModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
