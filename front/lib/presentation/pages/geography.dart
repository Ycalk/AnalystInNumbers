import 'package:flutter/material.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/pie/stat_by_area.dart';
import 'package:front/presentation/widgets/charts/stat_by_area.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/tables/stat_by_area.dart';

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
                            child:StatByAreaTable(stat: salaryByArea, unit: 'Зарплата (руб.)'),
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
                              table: StatByAreaTable(stat: countByArea, unit: 'Количество вакансий (шт.)'),
                            ),
                          ),
                          const SizedBox(height: 60,),
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

class GeographyPageTexts{
  static const String pageName = 'География';
}