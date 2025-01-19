import 'package:flutter/material.dart';
import 'package:front/domain/entities/char_data.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class StatTable extends StatelessWidget {
  final List<DataItem<Object, Object>> stat;
  final TableColumnWidth columnWidth;
  final String unit;
  final String columnName;
  const StatTable({super.key, required this.stat, 
  required this.unit, 
  required this.columnName,
  this.columnWidth = const FlexColumnWidth()});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: columnWidth,
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
              child: SelectableText(
                'Город',
                style: TextStyles.subtitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
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
                child: SelectableText(
                  spot.x.toString(),
                  style: TextStyles.description,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SelectableText(
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