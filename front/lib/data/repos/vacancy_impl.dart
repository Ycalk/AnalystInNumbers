import 'package:front/data/source/vacancy_client.dart';
import 'package:front/domain/entities/vacancy.dart';
import 'package:front/domain/repos/vacancy.dart';

class VacancyRepositoryImpl implements VacancyRepository {
  final VacancyClient _client;

  VacancyRepositoryImpl() : _client = VacancyClient();

  @override
  Future<List<Vacancy>> getVacancies() async {
    return (await _client.getVacancies()).map((e) => Vacancy.fromJson(e)).toList();
  }
}