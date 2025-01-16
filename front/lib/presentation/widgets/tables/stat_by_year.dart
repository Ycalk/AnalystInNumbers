import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class StatByYearTable extends StatelessWidget {
  final List<FlSpot> stat;
  final String unit;
  const StatByYearTable({super.key, required this.stat, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Table(
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
        }),
      ],
    );
  }
}