import 'package:front/domain/entities/char_data.dart';

abstract class GeneralStatsRepository {
  Future<List<LineDataItem>> getSalaryByYear();
  Future<List<LineDataItem>> getCountByYear();
  Future<List<BarDataItem>> getStatByCity();
}