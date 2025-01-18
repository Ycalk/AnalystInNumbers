
import 'package:dio/dio.dart';

class VacancyClient {
  final dio = Dio(BaseOptions(
    baseUrl: "https://bbaa9o8fmfofjqhf6vqb.containers.yandexcloud.net",
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<List<Map<String, dynamic>>> getVacancies() async {
    final response = await dio.get('/vacancies');
    return List<Map<String, dynamic>>.from(response.data);
  }
}