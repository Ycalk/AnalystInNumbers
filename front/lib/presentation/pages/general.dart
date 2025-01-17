import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/widgets/charts/pie/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_year.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/tables/stat_by_area.dart';
import 'package:front/presentation/widgets/tables/stat_by_year.dart';

class GeneralPage extends StatelessWidget {
  static const String routeName = '/general';
  GeneralPage({super.key});

  final GeneralStats generalStats = GeneralStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('General Stats'),
      ),
      body: FutureLoader(future: generalStats.getSalaryByYear(), 
        builder: (salaryByYear) {
          return FutureLoader(future: generalStats.getCountByYear(), 
            builder: (countByYear) {
              return FutureLoader(future: generalStats.getSalaryByArea(), 
                builder: (salaryByCity) {
                  return FutureLoader(future: generalStats.getCountByArea(),
                    builder: (countByArea) {
                      return getWidgets(salaryByYear, countByYear, salaryByCity, countByArea);
                    },
                  );
                }
              );
            }
          );
        }
      ),
    );
  }
  Widget getWidgets (List<FlSpot> salaryByYear, List<FlSpot> countByYear, 
    List<BarDataItem> salaryByCity, List<PieDataItem> countByArea) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 60,),
            // Line Charts
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Динамика уровня зарплат по годам',
                          style: TextStyles.subtitle,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: StatByYearChart(spots: salaryByYear, unit: 'руб.'),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: StatByYearTable(stat: salaryByYear, unit: 'Зарплата (руб.)'),
                      ),
                    ],
                  ) 
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Динамика количества вакансий по годам',
                          style: TextStyles.subtitle,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: StatByYearChart(spots: countByYear, unit: 'шт.'),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: StatByYearTable(stat: countByYear, unit: 'Количество вакансий (шт.)'),
                      ),
                    ],
                  ) 
                )
              ],
            ),
            // Bar chart
            const SizedBox(height: 60,),
            Text(
              'Уровень зарплат по регионам',
              style: TextStyles.subtitle,
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: StatByAreaChart(data: salaryByCity),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: StatByAreaTable(stat: salaryByCity, unit: 'Зарплата (руб.)'),
            ),
            const SizedBox(height: 60,),
            Text(
              'Доля вакансий по регионам',
              style: TextStyles.subtitle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: StatByAreaPieChart(
                data: countByArea,
                table: StatByAreaTable(stat: countByArea, unit: 'Количество вакансий (шт.)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}