import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/charts/stat_by_year.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GeneralPage extends StatefulWidget {
  static const String routeName = '/general';
  const GeneralPage({Key? key}) : super(key: key);

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
                  return Padding(
                    padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
                    child: AlignedGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Динамика уровня зарплат по годам',
                                  style: TextStyles.subtitle,
                                ),
                                getStatByYearChart(salaryByYear, 'руб.'),
                              ],
                            ),
                          );
                        } else if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Динамика количества вакансий по годам',
                                  style: TextStyles.subtitle,
                                ),
                                getStatByYearChart(countByYear, 'шт.'),
                              ],
                            ),
                          );
                        } else if (index == 2) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: getStatByYearTable(salaryByYear, 'Зарплата (руб.)'),
                          );
                        } else if (index == 3) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: getStatByYearTable(countByYear, 'Количество вакансий (шт.)'),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
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

  Widget getStatByYearChart(List<FlSpot> stat, String unit) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: StatByYearChart(
        spots: stat,
        unit: unit,
      ),
    );
  }

  Widget getStatByYearTable(List<FlSpot> stat, String unit) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
      child: Table(
        border: TableBorder.all(
          color: AppColors.onTertiaryLight,
          width: 3,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Год',
                  style: TextStyles.subtitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  unit,
                  style: TextStyles.subtitle,
                ),
              ),
            ],
          ),
          ...stat.map((spot) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    spot.x.toString(),
                    style: TextStyles.description,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    spot.y.toString(),
                    style: TextStyles.description,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

}


class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}