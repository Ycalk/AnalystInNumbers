import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class SalaryByYearChart extends StatefulWidget {
  final List<FlSpot> spots;
  const SalaryByYearChart({super.key, required this.spots});

  @override
  State<SalaryByYearChart> createState() => _SalaryByYearChartState();
}

class _SalaryByYearChartState extends State<SalaryByYearChart> {
  List<Color> gradientColors = [
    AppColors.primaryLight!,
    AppColors.primary,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(getChart()),
          ),
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'Показать среднее',
              style: TextStyles.description.copyWith(
                color: showAvg ? AppColors.description : Colors.black,
              )
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    final shownValues = [2005, 2010, 2015, 2020, 2024];
    if (shownValues.contains(value.toInt())) {
      text = Text(
        value.toInt().toString(),
        style: TextStyles.description
      );
    } else {
      text = const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData getChart() {
    double avg = 0;
    for (final spot in widget.spots) {
      avg += spot.y;
    }
    avg /= widget.spots.length;
    avg = avg.roundToDouble();
    final avgSpots = widget.spots.map((spot) => FlSpot(spot.x, avg)).toList();

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppColors.tertiary,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                'Год: ${spot.x}\n${spot.y}р.',
                TextStyles.description.copyWith(color: AppColors.primary),
              );
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: AppColors.description,
            width: 1,
          ),
          left: BorderSide(
            color: AppColors.onTertiaryLight,
            width: 1,
          ),
          right: BorderSide(
            color: AppColors.onTertiaryLight,
            width: 1,
          ),
          top: BorderSide(
            color: AppColors.onTertiaryLight,
            width: 1,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          show: !showAvg,
          spots: widget.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.3))
                  .toList(),
            ),
          ),
        ),
        LineChartBarData(
          show: showAvg,
          spots: avgSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}