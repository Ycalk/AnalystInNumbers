import 'package:fl_chart/fl_chart.dart';

class LineDataItem {
  final double x;
  final double y;

  LineDataItem(this.x, this.y);

  FlSpot toSpot() {
    return FlSpot(x, y);
  }
}

class BarDataItem {
  final String x;
  final double y;

  BarDataItem(this.x, this.y);
}

class PieDataItem {
  final String x;
  final double y;
  final double proportion;

  PieDataItem(this.x, this.y, this.proportion);
}