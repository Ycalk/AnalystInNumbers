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
import 'package:front/presentation/widgets/stat_table.dart';

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
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 1200) {
                                return _buildDesktopLayout(salaryByYear, countByYear, salaryByCity, countByArea, skillsByYear);
                              } else if (constraints.maxWidth > 800) {
                                return _buildTabletLayout(salaryByYear, countByYear, salaryByCity, countByArea, skillsByYear);
                              } else {
                                return _buildMobileLayout(salaryByYear, countByYear, salaryByCity, countByArea, skillsByYear);
                              }
                            },
                          );
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

  Widget _buildDesktopLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear, 
    List<BarDataItem> salaryByCity, List<PieDataItem> countByArea, SkillsData skillsByYear){
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => switch (index){
        0 => Padding(
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
                            'Динамика уровня зарплат по годам',
                            style: TextStyles.subtitle,
                            textAlign: TextAlign.center
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
                                  unit: 'Зарплата', columnName: 'Год',)
                        ),
                      ],
                    ) 
                  ).animate()
                    .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200),),
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: SelectableText(
                            'Динамика количества вакансий по годам',
                            style: TextStyles.subtitle,
                            textAlign: TextAlign.center
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
                    duration: const Duration(milliseconds: 200),)
                ],
              ),
            ],
          ),
        ),
        
        1 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Уровень зарплат по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StatByAreaChart(data: salaryByCity),
              ),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        2 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200.0),
                child: StatTable(
                  stat: salaryByCity, 
                  unit: 'Зарплата',
                  columnName: 'Город',
                ),
              ),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        3 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Доля вакансий по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StatByAreaPieChart(
                  data: countByArea,
                  table: StatTable(
                    stat: countByArea, 
                    unit: 'Количество вакансий',
                    columnName: 'Город',
                    columnWidth: const IntrinsicColumnWidth(),
                  ),
                ),
              ),
            ],
          ),
        ),

        4 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'ТОП-20 навыков по годам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: KeySkillsInfo(data: skillsByYear,),
              ),
            ],
          ).animate().fade(begin: 0, end: 1, curve: Curves.easeIn, duration: const Duration(milliseconds: 200)),
        ),


        5 => const Column(
          children: [
            SizedBox(height: 100,),
            Footer()
          ]
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildTabletLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear, 
    List<BarDataItem> salaryByCity, List<PieDataItem> countByArea, SkillsData skillsByYear) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => switch (index){
        0 => Padding(
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
                          'Динамика уровня зарплат по годам',
                          style: TextStyles.subtitle,
                          textAlign: TextAlign.center
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
                                unit: 'Зарплата', columnName: 'Год',)
                      ),
                    ],
                  ).animate()
                    .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200),),

                  Column(
                    children: [
                      const SizedBox(height: 60,),
                      Center(
                        child: SelectableText(
                          'Динамика количества вакансий по годам',
                          style: TextStyles.subtitle,
                          textAlign: TextAlign.center
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
                    duration: const Duration(milliseconds: 200),)
                ],
              ),
            ],
          ),
        ),
        
        1 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Уровень зарплат по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              StatByAreaChart(data: salaryByCity, rightPadding: 80),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        2 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: StatTable(
                  stat: salaryByCity, 
                  unit: 'Зарплата',
                  columnName: 'Город',
                ),
              ),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        3 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Доля вакансий по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StatByAreaPieChart(
                  data: countByArea,
                  table: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: StatTable(
                      stat: countByArea, 
                      unit: 'Количество вакансий',
                      columnName: 'Город',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        4 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'ТОП-20 навыков по годам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: KeySkillsInfo(data: skillsByYear,),
              ),
            ],
          ).animate().fade(begin: 0, end: 1, curve: Curves.easeIn, duration: const Duration(milliseconds: 200)),
        ),


        5 => const Column(
          children: [
            SizedBox(height: 100,),
            Footer()
          ]
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildMobileLayout(List<FlSpot> salaryByYear, List<FlSpot> countByYear, 
    List<BarDataItem> salaryByCity, List<PieDataItem> countByArea, SkillsData skillsByYear) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => switch (index){
        0 => Padding(
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
                          'Динамика уровня зарплат по годам',
                          style: TextStyles.subtitle,
                          textAlign: TextAlign.center
                        ),
                      ),
                      const SizedBox(height: 30,),
                      StatByYearChart(spots: salaryByYear, unit: 'руб.'),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: StatTable(stat: salaryByYear.map((e) => DataItem(e.x, e.y),).toList(), 
                                unit: 'Зарплата', columnName: 'Год',)
                      ),
                    ],
                  ).animate()
                    .moveX(begin: -100, end: 0, curve: Curves.easeOutCubic, 
                      duration: const Duration(milliseconds: 200),),

                  Column(
                    children: [
                      const SizedBox(height: 60,),
                      Center(
                        child: SelectableText(
                          'Динамика количества вакансий по годам',
                          style: TextStyles.subtitle,
                          textAlign: TextAlign.center
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
                    duration: const Duration(milliseconds: 200),)
                ],
              ),
            ],
          ),
        ),
        
        1 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Уровень зарплат по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              StatByAreaChart(
                data: salaryByCity,
                rightPadding: 30,
              ),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        2 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StatTable(
                  stat: salaryByCity, 
                  unit: 'Зарплата',
                  columnName: 'Город',
                ),
              ),
            ],
          ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
        ),
        
        3 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'Доля вакансий по регионам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StatByAreaPieChart(
                  centerSpaceRadius: 50,
                  radius: 100,
                  data: countByArea,
                  table: StatTable(
                    stat: countByArea, 
                    unit: 'Количество вакансий',
                    columnName: 'Город',
                  ),
                ),
              ),
            ],
          ),
        ),

        4 => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SelectableText(
                'ТОП-20 навыков по годам',
                style: TextStyles.subtitle,
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: KeySkillsInfo(data: skillsByYear,),
              ),
            ],
          ).animate().fade(begin: 0, end: 1, curve: Curves.easeIn, duration: const Duration(milliseconds: 200)),
        ),


        5 => const Column(
          children: [
            SizedBox(height: 50,),
            Footer()
          ]
        ),
        _ => const SizedBox.shrink(),
      },
    );
  } 
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}