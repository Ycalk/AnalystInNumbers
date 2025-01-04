import 'package:fl_chart/fl_chart.dart';

class LineDataItem {
  final double x;
  final double y;

  LineDataItem(this.x, this.y);

  FlSpot toSpot() {
    return FlSpot(x, y);
  }
}