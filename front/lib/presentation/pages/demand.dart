import 'package:flutter/material.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/stat_by_year.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/tables/stat_by_year.dart';

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
                                      child: StatByYearTable(stat: salaryByYear, unit: 'Зарплата (руб.)'),
                                    ),
                                  ],
                                ) 
                              ),
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
                                      child: StatByYearTable(stat: countByYear, unit: 'Количество вакансий (шт.)'),
                                    ),
                                  ],
                                ) 
                              )
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
          );
        }
      ),
    );
  }
}

class DemandPageTexts{
  static const String pageName = 'Востребованность';
}