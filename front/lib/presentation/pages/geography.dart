import 'package:flutter/material.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/stat_by_city.dart';
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
        title: const Text('Geography'),
      ),
      body: FutureLoader(future: professionStats.getSalaryByArea(), 
        builder: (salaryByArea) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Text(
                  'Уровень зарплат по городам',
                  style: TextStyles.subtitle,
                ),
                const SizedBox(height: 20,),
                StatByAreaChart(data: salaryByArea),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 200.0, right: 200.0, bottom: 50),
                  child:StatByAreaTable(stat: salaryByArea, unit: 'Зарплата (руб.)'),
                ),
              ],
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