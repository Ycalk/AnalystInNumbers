import 'package:front/data/models/stats.dart';
import 'package:front/data/source/stats_client.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/repos/profession_stats.dart';

class ProfessionStatsRepositoryImpl implements ProfessionStatsRepository {
  final StatsClient _client;

  ProfessionStatsRepositoryImpl() : _client = StatsClient();
  
  Future<List<LineDataItem>> getStatByYear(Future<List<Stat<double, double>>> stat) async {
    return (await stat).map((e) => LineDataItem(e.v1, e.v2)).toList();
  }

  @override
  Future<List<LineDataItem>> getSalaryByYear() async {
    return getStatByYear(_client.getSalaryByYear(AnalyticsType.profession));
  }

  @override
  Future<List<LineDataItem>> getCountByYear() async {
    return getStatByYear(_client.getCountByYear(AnalyticsType.profession));
  }

  @override
  Future<List<BarDataItem>> getStatByArea() async {
    return (await _client.getSalaryByArea(AnalyticsType.profession)).map((e) => BarDataItem(e.v1, e.v2)).toList();
  }
}