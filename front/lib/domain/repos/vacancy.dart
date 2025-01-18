import 'package:front/domain/entities/vacancy.dart';

abstract class VacancyRepository {
  Future<List<Vacancy>> getVacancies();
}