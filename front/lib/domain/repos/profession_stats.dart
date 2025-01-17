import 'package:front/domain/entities/char_data.dart';

abstract class ProfessionStatsRepository {
  Future<List<LineDataItem>> getSalaryByYear();
  Future<List<LineDataItem>> getCountByYear();
  Future<List<BarDataItem>> getStatByArea();
  Future<List<PieDataItem>> getCountByArea();
}