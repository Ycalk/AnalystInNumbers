import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/stat_by_year.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/stat_table.dart';

class DemandPage extends StatelessWidget {
  static const String routeName = '/demand';

  final ProfessionStats professionStats = ProfessionStats();
  DemandPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Analyst Demand'),
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
      ),
      body: FutureLoader(future: professionStats.getSalaryByYear(), 
        builder: (salaryByYear) {
          return FutureLoader(future: professionStats.getCountByYear(), 
            builder: (countByYear) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    return _buildDesktopLayout(salaryByYear, countByYear);
                  } else if (constraints.maxWidth > 800) {
                    return _buildTabletLayout(salaryByYear, countByYear);
                  } else {
                    return _buildMobileLayout(salaryByYear, countByYear);
                  }
                },
              );
            }
          );
        }
      ),
    );
  }

  Widget _buildDesktopLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                            child: SelectableText(
                              'Динамика уровня зарплат по годам (Аналитик)',
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
                            child: StatTable(stat: salaryByYear.map((e) => DataItem(e.x, e.y),).toList(), 
                              unit: 'Зарплата', columnName: 'Год',),
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
                              'Динамика количества вакансий по годам (Аналитик)',
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
                            child: StatTable(stat: countByYear.map((e) => DataItem(e.x, e.y)).toList(), 
                              unit: 'Количество вакансий', columnName: 'Год',),
                          ),
                        ],
                      ) 
                    ).animate()
                      .moveX(begin: 100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200))
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 100,),
          const Footer()
        ],
      ),
    );
  }

  Widget _buildTabletLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Wrap(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SelectableText(
                            'Динамика уровня зарплат по годам (Аналитик)',
                            style: TextStyles.subtitle,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: StatByYearChart(spots: salaryByYear, unit: 'руб.'),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          child: StatTable(stat: salaryByYear.map((e) => DataItem(e.x, e.y),).toList(), 
                            unit: 'Зарплата', columnName: 'Год',),
                        ),
                      ],
                    ).animate()
                      .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                        duration: const Duration(milliseconds: 200)),

                    Column(
                      children: [
                        const SizedBox(height: 60,),
                        Center(
                          child: SelectableText(
                            'Динамика количества вакансий по годам (Аналитик)',
                            style: TextStyles.subtitle,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: StatByYearChart(spots: countByYear, unit: 'шт.'),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          child: StatTable(stat: countByYear.map((e) => DataItem(e.x, e.y)).toList(), 
                            unit: 'Количество вакансий', columnName: 'Год',),
                        ),
                      ],
                    ).animate()
                      .moveX(begin: 100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200))
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 100,),
          const Footer()
        ],
      ),
    );
  }

  Widget _buildMobileLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Wrap(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SelectableText(
                            'Динамика уровня зарплат по годам (Аналитик)',
                            style: TextStyles.subtitle,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        StatByYearChart(spots: salaryByYear, unit: 'руб.'),
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: StatTable(stat: salaryByYear.map((e) => DataItem(e.x, e.y),).toList(), 
                            unit: 'Зарплата', columnName: 'Год',),
                        ),
                      ],
                    ).animate()
                      .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                        duration: const Duration(milliseconds: 200)),

                    Column(
                      children: [
                        const SizedBox(height: 60,),
                        Center(
                          child: SelectableText(
                            'Динамика кол-ва вакансий по годам (Аналитик)',
                            style: TextStyles.subtitle,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        StatByYearChart(spots: countByYear, unit: 'шт.'),
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: StatTable(stat: countByYear.map((e) => DataItem(e.x, e.y)).toList(), 
                            unit: 'Количество вакансий', columnName: 'Год',),
                        ),
                      ],
                    ).animate()
                      .moveX(begin: 100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200))
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 50,),
          const Footer()
        ],
      ),
    );
  }
}

class DemandPageTexts{
  static const String pageName = 'Востребованность';
}