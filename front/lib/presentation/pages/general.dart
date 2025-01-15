import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/widgets/charts/stat_by_city.dart';
import 'package:front/presentation/widgets/charts/stat_by_year.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:front/presentation/widgets/tables/stat_by_area.dart';
import 'package:front/presentation/widgets/tables/stat_by_year.dart';

class GeneralPage extends StatefulWidget {
  static const String routeName = '/general';
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final GeneralStats generalStats = GeneralStats();

  late Future<List<FlSpot>> salaryByYearFuture;
  late Future<List<FlSpot>> countByYearFuture;

  @override
  void initState() {
    super.initState();
    salaryByYearFuture = generalStats.getSalaryByYear();
    countByYearFuture = generalStats.getCountByYear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('General'),
      ),
      body: FutureBuilder<List<FlSpot>>(
        future: generalStats.getSalaryByYear(),
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
            final salaryByYear = snapshot.data!;
            return FutureBuilder<List<FlSpot>>(
              future: generalStats.getCountByYear(),
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
                  final countByYear = snapshot.data!;
                  return FutureBuilder<List<BarDataItem>>(
                    future: generalStats.getSalaryByCity(),
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
                        final salaryByCity = snapshot.data!;
                        return Expanded(child: getWidgets(salaryByYear, countByYear, salaryByCity));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
  
  Widget getWidgets(List<FlSpot> salaryByYear, List<FlSpot> countByYear, List<BarDataItem> salaryByCity){
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
      child: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 100,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          pattern: [
            const QuiltedGridTile(5, 50),
            const QuiltedGridTile(5, 50),

            const QuiltedGridTile(30, 50),
            const QuiltedGridTile(30, 50),

            const QuiltedGridTile(47, 50),
            const QuiltedGridTile(47, 50),

            const QuiltedGridTile(5, 100),
            const QuiltedGridTile(66, 100),
            const QuiltedGridTile(66, 100),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: 9,
          (context, index) {
            return switch (index) {
              0 => Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Динамика уровня зарплат по годам',
                        style: TextStyles.subtitle,
                      ),
                    ),
                  ),
              1 => Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Динамика количества вакансий по годам',
                        style: TextStyles.subtitle,
                      ),
                    ),
                  ),
              2 => Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                    child: StatByYearChart(spots: salaryByYear, unit: 'руб.')
                  ),
              3 => Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                    child: StatByYearChart(spots: countByYear, unit: 'шт.')
                  ),
              4 => Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80, top: 0),
                      child: StatByYearTable(stat: salaryByYear, unit: 'Зарплата (руб.)'),
                    ),
              5 => Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80, top: 0),
                      child: StatByYearTable(stat: countByYear, unit: 'Количество вакансий (шт.)'),
                    ),
              6 => Center(
                    child: Text(
                      'Уровень зарплат по городам',
                      style: TextStyles.subtitle,
                    ),
              ),
              7 => StatByCityChart(data: salaryByCity),
              8 => Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 200.0, right: 200.0),
                    child:StatByAreaTable(stat: salaryByCity, unit: 'Зарплата (руб.)'),
                  ),
              _ => const SizedBox.shrink(), 
            };
          },
        ),
      )
    );
  }
}


class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}