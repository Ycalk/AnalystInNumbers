import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/entities/skills_data.dart';

abstract class GeneralStatsRepository {
  Future<List<LineDataItem>> getSalaryByYear();
  Future<List<LineDataItem>> getCountByYear();
  Future<List<BarDataItem>> getSalaryByArea();
  Future<List<PieDataItem>> getCountByArea();
  Future<SkillsData> getSkillsByYear();
}