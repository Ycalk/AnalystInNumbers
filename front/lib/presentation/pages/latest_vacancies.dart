import 'package:flutter/material.dart';
import 'package:front/domain/usecases/vacancy.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
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
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
      ),
      body: FutureLoader(future: vacanciesList.getVacancies(),
        builder: (vacanciesList) {
          return ListView.builder(
            itemCount: vacanciesList.length + 1,
            itemBuilder: (context, index) {
              if (index == vacanciesList.length) {
                return const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Footer(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: VacancyCard(vacancy: vacanciesList[index]),
                );
              }
            },
          );
        }
      )
    );
  }
}

class LatestVacanciesPageTexts{
  static const String pageName = 'Последние вакансии';
}