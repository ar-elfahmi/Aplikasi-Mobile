import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  static const String _endpoint = 'https://jsonplaceholder.typicode.com/posts';

  final Dio _dio;
  final http.Client _httpClient;

  MahasiswaAktifRepository({Dio? dio, http.Client? httpClient})
      : _dio = dio ?? Dio(),
        _httpClient = httpClient ?? http.Client();

  Future<List<MahasiswaAktifModel>> getData() async {
    try {
      return await _getPostsWithHttp();
    } catch (_) {
      return _getPostsWithDio();
    }
  }

  Future<List<MahasiswaAktifModel>> _getPostsWithHttp() async {
    final response = await _httpClient.get(Uri.parse(_endpoint));
    if (response.statusCode != 200) {
      throw Exception('HTTP error: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => MahasiswaAktifModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<MahasiswaAktifModel>> _getPostsWithDio() async {
    final response = await _dio.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Dio error: ${response.statusCode}');
    }

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((e) => MahasiswaAktifModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
