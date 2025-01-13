import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/charts/stat_by_year.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GeneralPage extends StatelessWidget {
  static const String routeName = '/general';
  final GeneralStats generalStats = GeneralStats();
  GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('General'),
      ),
      body: Padding(
      padding: const EdgeInsets.only(top: 70.0, left: 16.0, right: 16.0),
      child: AlignedGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Динамика уровня зарплат по годам', style: TextStyles.subtitle,),
                getSalaryByYearChart(),
              ],
            );
          } else if (index == 1) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Динамика количества вакансий по годам', style: TextStyles.subtitle,),
                getCountByYearChart(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
    );
  }

  Widget getStatByYearChart(Future<List<FlSpot>> future, String unit) {
    return FutureBuilder<List<FlSpot>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Column(
            children: [
              const Text(Texts.errorMessage),
              Text('Error: ${snapshot.error}')
            ],
          );
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: StatByYearChart(spots: snapshot.data!, unit: unit,)
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget getSalaryByYearChart() {
    return getStatByYearChart(generalStats.getSalaryByYear(), 'руб.');
  }

  Widget getCountByYearChart(){
    return getStatByYearChart(generalStats.getCountByYear(), 'шт.');
  }


}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}