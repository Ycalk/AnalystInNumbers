import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/pie/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_area.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/stat_table.dart';

class GeographyPage extends StatelessWidget {
  static const String routeName = '/geography';
  
  final ProfessionStats professionStats = ProfessionStats();
  GeographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Analyst Geography'),
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
      ),
      body: FutureLoader(future: professionStats.getCountByArea(),
        builder: (countByArea) {
          return FutureLoader(future: professionStats.getSalaryByArea(), 
            builder: (salaryByArea) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    return _buildDesktopLayout(countByArea, salaryByArea);
                  } else if (constraints.maxWidth > 800) {
                    return _buildTabletLayout(countByArea, salaryByArea);
                  } else {
                    return _buildMobileLayout(countByArea, salaryByArea);
                  }
                },
              );
            }
          );
        }
      ),
    );
  }

  Widget _buildDesktopLayout(List<PieDataItem> countByArea, List<BarDataItem> salaryByArea){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                SelectableText(
                  'Уровень зарплат по регионам (Аналитик)',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: StatByAreaChart(data: salaryByArea),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child:StatTable(stat: salaryByArea, unit: 'Зарплата (руб.)', columnName: 'Город',),
                ),
                const SizedBox(height: 60,),
                SelectableText(
                  'Доля вакансий по регионам (Аналитик)',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: StatByAreaPieChart(
                    data: countByArea,
                    table: StatTable(
                      stat: countByArea, 
                      unit: 'Количество вакансий (шт.)', 
                      columnName: 'Город',
                      columnWidth: const IntrinsicColumnWidth()
                    ),
                  ),
                ),
              ],
            ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
          ),

          const SizedBox(height: 100,),
          const Footer()
        ],
      ),
    );
  }

  Widget _buildTabletLayout(List<PieDataItem> countByArea, List<BarDataItem> salaryByArea){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                SelectableText(
                  'Уровень зарплат по регионам (Аналитик)',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                StatByAreaChart(data: salaryByArea, rightPadding: 80,),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child:StatTable(stat: salaryByArea, unit: 'Зарплата (руб.)', columnName: 'Город',),
                ),
                const SizedBox(height: 60,),
                SelectableText(
                  'Доля вакансий по регионам (Аналитик)',
                  style: TextStyles.subtitle,
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
                        unit: 'Количество вакансий (шт.)', 
                        columnName: 'Город',
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
          ),

          const SizedBox(height: 100,),
          const Footer()
        ],
      ),
    );
  }

  Widget _buildMobileLayout(List<PieDataItem> countByArea, List<BarDataItem> salaryByArea){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                SelectableText(
                  'Уровень зарплат по регионам (Аналитик)',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 30,),
                StatByAreaChart(data: salaryByArea, rightPadding: 30),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child:StatTable(stat: salaryByArea, unit: 'Зарплата (руб.)', columnName: 'Город',),
                ),
                const SizedBox(height: 60,),
                SelectableText(
                  'Доля вакансий по регионам (Аналитик)',
                  style: TextStyles.subtitle,
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
                      unit: 'Количество вакансий (шт.)', 
                      columnName: 'Город',
                    ),
                  ),
                ),
              ],
            ).animate().moveY(begin: 100, end: 0, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 200)),
          ),

          const SizedBox(height: 100,),
          const Footer()
        ],
      ),
    );
  }
}

class GeographyPageTexts{
  static const String pageName = 'География';
}