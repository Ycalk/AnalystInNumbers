import 'package:front/data/models/stats.dart';

class StatsClient {
  Future<List<StatDD>> getSalaryByYear() async {
    return Future.value([
      StatDD(2003, 41092),
      StatDD(2004, 45476),
      StatDD(2005, 47343),
      StatDD(2006, 43925),
      StatDD(2007, 51349),
      StatDD(2008, 54218),
      StatDD(2009, 66134),
      StatDD(2010, 56504),
      StatDD(2011, 50784),
      StatDD(2012, 59843),
      StatDD(2013, 45319),
      StatDD(2014, 59805),
      StatDD(2015, 62361),
      StatDD(2016, 61363),
      StatDD(2017, 64381),
      StatDD(2018, 66768),
      StatDD(2019, 66326),
      StatDD(2020, 84492),
      StatDD(2021, 98782),
      StatDD(2022, 95416),
      StatDD(2023, 106854),
      StatDD(2024, 129183),
    ]);
  }
  Future<List<StatDD>> getCountByYear(){
    return Future.value([
      StatDD(2003, 54),
      StatDD(2004, 238),
      StatDD(2005, 480),
      StatDD(2006, 949),
      StatDD(2007, 1389),
      StatDD(2008, 832),
      StatDD(2009, 119),
      StatDD(2010, 132),
      StatDD(2011, 145),
      StatDD(2012, 173),
      StatDD(2013, 240),
      StatDD(2014, 263),
      StatDD(2015, 223),
      StatDD(2016, 274),
      StatDD(2017, 381),
      StatDD(2018, 500),
      StatDD(2019, 527),
      StatDD(2020, 550),
      StatDD(2021, 1093),
      StatDD(2022, 1583),
      StatDD(2023, 1681),
      StatDD(2024, 1447),
    ]);
  }
}
