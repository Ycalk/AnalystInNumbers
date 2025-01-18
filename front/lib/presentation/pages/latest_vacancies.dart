import 'package:flutter/material.dart';
import 'package:front/domain/usecases/vacancy.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/vacancy_card.dart';

class LatestVacanciesPage extends StatelessWidget {
  static const String routeName = '/latest_vacancies';
  final VacanciesList vacanciesList = VacanciesList();

  LatestVacanciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Analyst Latest Vacancies'),
      ),
      body: FutureLoader(future: vacanciesList.getVacancies(),
        builder: (vacanciesList) {
          return ListView.builder(
            itemCount: vacanciesList.length,
            itemBuilder: (context, index) => VacancyCard(vacancy: vacanciesList[index]),
            padding: const EdgeInsets.all(60),
          );
        }
      )
    );
  }
}

class LatestVacanciesPageTexts{
  static const String pageName = 'Последние вакансии';
}