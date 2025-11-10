import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  // Get list of all surahs
  Future<List<Map<String, dynamic>>> getAllSurahs() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/surah'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load surahs');
      }
    } catch (e) {
      log('Error fetching surahs: $e');
      return [];
    }
  }

  // Get a specific surah with translation
  Future<Map<String, dynamic>?> getSurah(
      int surahNumber, String edition) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/surah/$surahNumber/$edition'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to load surah');
      }
    } catch (e) {
      log('Error fetching surah: $e');
      return null;
    }
  }

  // Get surah with both Arabic and English translation
  Future<Map<String, dynamic>?> getSurahWithTranslation(int surahNumber) async {
    try {
      // Fetch Arabic text and English translation together
      final response = await http.get(Uri.parse(
          '$baseUrl/surah/$surahNumber/editions/quran-uthmani,en.asad'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'arabic': data['data'][0],
          'translation': data['data'][1],
        };
      } else {
        throw Exception('Failed to load surah with translation');
      }
    } catch (e) {
      log('Error fetching surah with translation: $e');
      return null;
    }
  }

  // Get a specific ayah
  Future<Map<String, dynamic>?> getAyah(int surahNumber, int ayahNumber) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ayah/$surahNumber:$ayahNumber/en.asad'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to load ayah');
      }
    } catch (e) {
      log('Error fetching ayah: $e');
      return null;
    }
  }
}
