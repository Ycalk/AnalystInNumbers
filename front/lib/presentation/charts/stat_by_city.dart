import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class StatByCity extends StatefulWidget {
  StatByCity({super.key, required this.data});

  final Color barBackgroundColor = AppColors.onTertiaryLight;
  final Color barColor = AppColors.primaryLight!;
  final Color touchedBarColor = AppColors.primary;
  final List<BarDataItem> data;

  @override
  State<StatefulWidget> createState() => StatByCityState();
}

class StatByCityState extends State<StatByCity> {
  final Duration animDuration = const Duration(milliseconds: 70);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          mainBarData(),
          duration: animDuration,
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    required bool isTouched,
  }) {
    return BarChartGroupData(
      groupVertically: false,
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y * 1.02 : y,
          color: isTouched ? widget.touchedBarColor : widget.barColor,
          width: 20,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor, width: 2)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.data.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.1,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
    );
  }
  List<BarChartGroupData> showingGroups() => 
    List.generate(widget.data.length, (i) =>
      makeGroupData(i, widget.data[i].y, isTouched: i == touchedIndex)
    );

  BarChartData mainBarData() {
    return BarChartData(
      rotationQuarterTurns: 1,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.white,
          tooltipHorizontalAlignment: FLHorizontalAlignment.left,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            var city = widget.data[group.x.toInt()].x;
            return BarTooltipItem(
              '$city\n',
              TextStyles.description.copyWith(color: AppColors.primary),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY / 1.02).toString(),
                  style: TextStyles.description.copyWith(color: AppColors.primary),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 230, getTitlesWidget: (value, meta) => const SizedBox(),),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 230,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false,),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var text = Text(widget.data[value.toInt()].x, style: TextStyles.description);
    return SideTitleWidget(
      meta: meta,
      space: 20,
      child: text,
    );
  }
}