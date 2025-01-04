

import 'package:front/data/source/stats_client.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/repos/general_stats.dart';

class GeneralStatsRepositoryImpl implements GeneralStatsRepository {
  final StatsClient _client;

  GeneralStatsRepositoryImpl() : _client = StatsClient();
  
  @override
  Future<List<LineDataItem>> getSalaryByYear() async {
    final stats = await _client.getSalaryByYear();
    return stats.map((e) => LineDataItem(e.d1, e.d2)).toList();
  }
}