import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class LatestVacanciesPage extends StatelessWidget {
  static const String routeName = '/latest_vacancies';

  const LatestVacanciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Latest Vacancies'),
      ),
      body: const Center(
        child: Text('Latest Vacancies Screen'),
      ),
    );
  }
}

class LatestVacanciesPageTexts{
  static const String pageName = 'Последние вакансии';
}