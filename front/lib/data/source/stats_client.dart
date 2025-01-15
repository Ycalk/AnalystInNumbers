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
      baseUrl: Uri.base.origin,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
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
      return (response.data as List).map((e) => Stat<double, double>(e['year'], (e['salary'] as double).roundToDouble())).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }

  Future<List<Stat<String, double>>> getSalaryByArea(AnalyticsType type) async {
    final response = await dio.get('/analytics/salary_by_area', queryParameters: {
      'type': type.stringValue
    });
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Stat<String, double>(e['area_name'], (e['salary'] as double).roundToDouble())).toList();
    } else {
      return Future.error('Failed to load data');
    }
  }
}
