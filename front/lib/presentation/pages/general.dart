import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/entities/skills_data.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/widgets/charts/pie/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_year.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/key_skills_info.dart';
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
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
      ),
      body: FutureLoader(future: generalStats.getSalaryByYear(), 
        builder: (salaryByYear) {
          return FutureLoader(future: generalStats.getCountByYear(), 
            builder: (countByYear) {
              return FutureLoader(future: generalStats.getSalaryByArea(), 
                builder: (salaryByCity) {
                  return FutureLoader(future: generalStats.getCountByArea(),
                    builder: (countByArea) {
                      return FutureLoader(future: generalStats.getSkillsByYear(),
                        builder: (skillsByYear) {
                          return getWidgets(salaryByYear, countByYear, salaryByCity, countByArea, skillsByYear);
                        },
                      );
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
    List<BarDataItem> salaryByCity, List<PieDataItem> countByArea, SkillsData skillsByYear) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
                            child: SelectableText(
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
                    ).animate()
                      .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                        duration: const Duration(milliseconds: 200)),
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                            child: SelectableText(
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
                    ).animate()
                      .moveX(begin: 100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200))
                  ],
                ),
                // Bar chart
                const SizedBox(height: 60,),
                SelectableText(
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
                SelectableText(
                  'Доля вакансий по регионам',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: StatByAreaPieChart(
                    data: countByArea,
                    table: StatByAreaTable(stat: countByArea, unit: 'Количество вакансий (шт.)'),
                  ),
                ),
          
                const SizedBox(height: 60,),
                SelectableText(
                  'ТОП-20 навыков по годам',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: KeySkillsInfo(data: skillsByYear,),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          const Footer()
        ],
      ),
    );
  }
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}