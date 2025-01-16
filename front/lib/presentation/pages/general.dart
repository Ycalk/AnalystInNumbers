import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/usecases/general_stats.dart';
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
        title: const Text('General'),
      ),
      body: FutureLoader(future: generalStats.getSalaryByYear(), 
        builder: (salaryByYear) {
          return FutureLoader(future: generalStats.getCountByYear(), 
            builder: (countByYear) {
              return FutureLoader(future: generalStats.getSalaryByArea(), 
                builder: (salaryByCity) {
                  return getWidgets(salaryByYear, countByYear, salaryByCity);
                }
              );
            }
          );
        }
      ),
    );
  }
  Widget getWidgets (List<FlSpot> salaryByYear, List<FlSpot> countByYear, List<BarDataItem> salaryByCity){
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
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
              'Уровень зарплат по городам',
              style: TextStyles.subtitle,
            ),
            const SizedBox(height: 30,),
            StatByAreaChart(data: salaryByCity),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: StatByAreaTable(stat: salaryByCity, unit: 'Зарплата (руб.)'),
            ),
            const SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}