

import 'package:fl_chart/fl_chart.dart';
import 'package:front/data/repos/general_stats_impl.dart';

class GeneralStats {
  GeneralStatsRepositoryImpl _repository = GeneralStatsRepositoryImpl();

  Future<List<FlSpot>> getSalaryByYear() {
    return _repository.getSalaryByYear().then((value) => value.map((e) => e.toSpot()).toList());
  }
}