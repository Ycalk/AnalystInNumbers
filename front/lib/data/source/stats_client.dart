import 'package:front/data/models/stats.dart';
import 'package:dio/dio.dart';

enum AnalyticsType {
  profession,
  all
}

extension AnalyticsTypeExtension on AnalyticsType {
  String get stringValue {
    switch (this) {
      case AnalyticsType.profession:
        return 'profession';
      case AnalyticsType.all:
        return 'all';
    }
  }
}

class StatsClient {
  final dio = Dio(BaseOptions(
    baseUrl: "https://bbaa9o8fmfofjqhf6vqb.containers.yandexcloud.net",
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<List<Stat<double, double>>> getCountByYear (AnalyticsType type) async {
    final response = await dio.get('/analytics/count_by_year', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Stat<double, double>(e['year'], e['count'])).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }

  Future<List<Stat<double, double>>> getSalaryByYear (AnalyticsType type) async {
    final response = await dio.get('/analytics/salary_by_year', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => 
        Stat<double, double>(e['year'], 
        double.parse((e['salary'] as double).toStringAsFixed(1)))
      ).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }

  Future<List<Stat<String, double>>> getSalaryByArea(AnalyticsType type) async {
    final response = await dio.get('/analytics/salary_by_area', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => 
        Stat<String, double>(e['area_name'], 
        double.parse((e['salary'] as double).toStringAsFixed(1)))
      ).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }

  Future<List<Stat<String, double>>> getCountByArea(AnalyticsType type) async {
    final response = await dio.get('/analytics/count_by_area', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Stat<String, double>(e['area_name'], e['count'])).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }

  Future<Map<String, List<String>>> getSkillsByYear(AnalyticsType type) async{
    final response = await dio.get('/analytics/skills_by_year', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as Map<String, dynamic>).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()));
    } else {
      return Future.error('Failed to load data');
    }
  }
}
