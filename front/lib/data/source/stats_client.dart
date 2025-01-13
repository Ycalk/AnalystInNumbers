import 'package:front/data/models/stats.dart';

class StatsClient {
  Future<List<Stat<double, double>>> getSalaryByYear() async {
    return Future.value([
      Stat<double, double>(2003, 41092),
      Stat<double, double>(2004, 45476),
      Stat<double, double>(2005, 47343),
      Stat<double, double>(2006, 43925),
      Stat<double, double>(2007, 51349),
      Stat<double, double>(2008, 54218),
      Stat<double, double>(2009, 66134),
      Stat<double, double>(2010, 56504),
      Stat<double, double>(2011, 50784),
      Stat<double, double>(2012, 59843),
      Stat<double, double>(2013, 45319),
      Stat<double, double>(2014, 59805),
      Stat<double, double>(2015, 62361),
      Stat<double, double>(2016, 61363),
      Stat<double, double>(2017, 64381),
      Stat<double, double>(2018, 66768),
      Stat<double, double>(2019, 66326),
      Stat<double, double>(2020, 84492),
      Stat<double, double>(2021, 98782),
      Stat<double, double>(2022, 95416),
      Stat<double, double>(2023, 106854),
      Stat<double, double>(2024, 129183),
    ]);
  }

  Future<List<Stat<double, double>>> getCountByYear(){
    return Future.value([
      Stat<double, double>(2003, 54),
      Stat<double, double>(2004, 238),
      Stat<double, double>(2005, 480),
      Stat<double, double>(2006, 949),
      Stat<double, double>(2007, 1389),
      Stat<double, double>(2008, 832),
      Stat<double, double>(2009, 119),
      Stat<double, double>(2010, 132),
      Stat<double, double>(2011, 145),
      Stat<double, double>(2012, 173),
      Stat<double, double>(2013, 240),
      Stat<double, double>(2014, 263),
      Stat<double, double>(2015, 223),
      Stat<double, double>(2016, 274),
      Stat<double, double>(2017, 381),
      Stat<double, double>(2018, 500),
      Stat<double, double>(2019, 527),
      Stat<double, double>(2020, 550),
      Stat<double, double>(2021, 1093),
      Stat<double, double>(2022, 1583),
      Stat<double, double>(2023, 1681),
      Stat<double, double>(2024, 1447),
    ]);
  }

  Future<List<Stat<String, double>>> getSalaryByCity(){
    return Future.value([]);
  }
}
