

import 'package:front/data/repos/vacancy_impl.dart';
import 'package:front/domain/entities/vacancy.dart';
import 'package:front/domain/repos/vacancy.dart';

class VacanciesList{
  final VacancyRepository repository = VacancyRepositoryImpl();

  VacanciesList();

  Future<List<Vacancy>> getVacancies() => repository.getVacancies();
}