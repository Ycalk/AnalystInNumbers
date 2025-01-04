import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/usecases/general_stats.dart';
import 'package:front/presentation/charts/salary_by_year.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';

class GeneralPage extends StatelessWidget {
  static const String routeName = '/general';
  final GeneralStats generalStats = GeneralStats();
  GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('General'),
      ),
      body: Center(
        child: FutureBuilder<List<FlSpot>>(
          future: generalStats.getSalaryByYear(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Text(Texts.errorMessage),
                  Text('Error: ${snapshot.error}')
                ],
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(100.0),
                child: SalaryByYearChart()
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}