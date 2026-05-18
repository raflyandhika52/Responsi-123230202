import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class ApiService {
  static Future<List<ArticleModel>> fetchData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List results = data['results'];
        return results.map((e) => ArticleModel.fromJson(e)).toList();
      }
    } catch (_) {
      // Saat request gagal, kembalikan daftar kosong agar UI tetap menunjukkan fallback.
    }

    return [];
  }

  static Future<ArticleModel> fetchDetail(String endpoint, int id) async {
    try {
      final response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/$id/"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ArticleModel.fromJson(data);
      }
    } catch (_) {
      // Jika detail gagal, lempar exception umum agar UI bisa menampilkan pesan yang lebih ramah.
    }

    throw Exception('Gagal memuat detail. Periksa koneksi internet.');
  }
}


