import 'package:fl_chart/fl_chart.dart';

class DataItem<T, U> {
  final T x;
  final U y;

  DataItem(this.x, this.y);
}

class LineDataItem extends DataItem<double, double> {
  LineDataItem(super.x, super.y);

  FlSpot toSpot() {
    return FlSpot(x, y);
  }
}

class BarDataItem extends DataItem<String, double> {
  BarDataItem(super.x, super.y);
}

class PieDataItem extends DataItem<String, double>{
  final double proportion;

  PieDataItem(super.x, super.y, this.proportion);
}