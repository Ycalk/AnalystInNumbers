import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/charts/pie/indicator.dart';

class StatByAreaPieChart extends StatefulWidget {
  final List<PieDataItem> data;
  final Widget table;
  const StatByAreaPieChart({super.key, required this.data, required this.table});

  @override
  State<StatefulWidget> createState() => StatByAreaPieChartState();
}

class StatByAreaPieChartState extends State<StatByAreaPieChart> {
  int touchedIndex = -1;

  final Color startColor = Color.lerp(AppColors.primaryLight, Colors.white, 0.5)!;
  final Color endColor = Color.lerp(AppColors.primary, Colors.white, 0.5)!;

  List<Color> get colors => List.generate(widget.data.length, (i) => 
    Color.lerp(startColor, endColor, i / (widget.data.length - 1))!);

  @override
  Widget build(BuildContext context) {
    final colorsList = colors;
    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 500,
            height: 500,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 100,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(colorsList.length, (i) {
              return Indicator(
                color: colorsList[i],
                text: widget.data[i].x,
                hoverText: '${widget.data[i].y} шт.',
                hovered: i == touchedIndex,
                onEnter: () => setState(() => touchedIndex = i),
                onExit: () => setState(() => touchedIndex = -1),
              );
            }),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: widget.table
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(){
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 30.0 : 12.0;
      final radius = isTouched ? 160.0 : 140.0;
      const shadows = [Shadow(color: AppColors.onTertiaryLight, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i],
        value: widget.data[i].y,
        title: '${(widget.data[i].proportion * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyles.description.copyWith(
          fontSize: fontSize,
          shadows: shadows,
        ),
      );
    });
  }
}

