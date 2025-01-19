import 'package:flutter/material.dart';
import 'package:front/domain/entities/vacancy.dart';
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
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return _buildDesktopLayout(vacanciesList);
              } else if (constraints.maxWidth > 800) {
                return _buildTabletLayout(vacanciesList);
              } else {
                return _buildMobileLayout(vacanciesList);
              }
            },
          );
        }
      )
    );
  }

  Widget _buildDesktopLayout(List<Vacancy> vacanciesList) {
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
            padding: EdgeInsets.only(
              left: 100, 
              right: 100, 
              bottom: 30, 
              top: index == 0 ? 60 : 30
            ),
            child: VacancyCard(vacancy: vacanciesList[index]),
          );
        }
      },
    );
  }

  Widget _buildTabletLayout(List<Vacancy> vacanciesList) {
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
            padding: EdgeInsets.only(
              left: 50, 
              right: 50, 
              bottom: 30, 
              top: index == 0 ? 60 : 30
            ),
            child: VacancyCard(vacancy: vacanciesList[index]),
          );
        }
      },
    );
  }

  Widget _buildMobileLayout(List<Vacancy> vacanciesList) {
    return ListView.builder(
      itemCount: vacanciesList.length + 1,
      itemBuilder: (context, index) {
        if (index == vacanciesList.length) {
          return const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Footer(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
              left: 30, 
              right: 30, 
              bottom: 20, 
              top: index == 0 ? 60 : 20
            ),
            child: VacancyCard(vacancy: vacanciesList[index]),
          );
        }
      },
    );
  }
}

class LatestVacanciesPageTexts{
  static const String pageName = 'Последние вакансии';
}