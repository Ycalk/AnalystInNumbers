import 'package:fl_chart/fl_chart.dart';
import 'package:front/data/repos/profession_stats_impl.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/entities/skills_data.dart';

class ProfessionStats {
  final ProfessionStatsRepositoryImpl _repository = ProfessionStatsRepositoryImpl();

  Future<List<FlSpot>> getSalaryByYear() {
    return _repository.getSalaryByYear().then((value) => value.map((e) => e.toSpot()).toList());
  }

  Future<List<FlSpot>> getCountByYear() {
    return _repository.getCountByYear().then((value) => value.map((e) => e.toSpot()).toList());
  }

  Future<List<BarDataItem>> getSalaryByArea() {
    return _repository.getStatByArea();
  }

  Future<List<PieDataItem>> getCountByArea() {
    return _repository.getCountByArea();
  }

  Future<SkillsData> getSkillsByYear() {
    return _repository.getSkillsByYear();
  }
}