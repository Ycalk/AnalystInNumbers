import 'package:flutter/material.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/stat_by_area.dart';
import 'package:front/presentation/widgets/drawer.dart';
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
      ),
      body: FutureLoader(future: professionStats.getSalaryByArea(), 
        builder: (salaryByArea) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Text(
                    'Уровень зарплат по городам (Аналитик)',
                    style: TextStyles.subtitle,
                  ),
                  const SizedBox(height: 30,),
                  StatByAreaChart(data: salaryByArea),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200.0),
                    child:StatByAreaTable(stat: salaryByArea, unit: 'Зарплата (руб.)'),
                  ),
                  const SizedBox(height: 60,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class GeographyPageTexts{
  static const String pageName = 'География';
}