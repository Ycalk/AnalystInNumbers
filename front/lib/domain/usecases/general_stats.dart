import 'package:fl_chart/fl_chart.dart';
import 'package:front/data/repos/general_stats_impl.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/entities/skills_data.dart';
import 'package:front/domain/repos/general_stats.dart';

class GeneralStats {
  final GeneralStatsRepository _repository = GeneralStatsRepositoryImpl();

  Future<List<FlSpot>> getSalaryByYear() {
    return _repository.getSalaryByYear().then((value) => value.map((e) => e.toSpot()).toList());
  }

  Future<List<FlSpot>> getCountByYear() {
    return _repository.getCountByYear().then((value) => value.map((e) => e.toSpot()).toList());
  }

  Future<List<BarDataItem>> getSalaryByArea() {
    return _repository.getSalaryByArea();
  }

  Future<List<PieDataItem>> getCountByArea() {
    return _repository.getCountByArea();
  }

  Future<SkillsData> getSkillsByYear() {
    return _repository.getSkillsByYear();
  }
}