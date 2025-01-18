import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:front/presentation/constants/theme.dart';
import 'package:front/presentation/pages/demand.dart';
import 'package:front/presentation/pages/general.dart';
import 'package:front/presentation/pages/geography.dart';
import 'package:front/presentation/pages/home.dart';
import 'package:front/presentation/pages/latest_vacancies.dart';
import 'package:front/presentation/pages/skills.dart';

void main() {
  usePathUrlStrategy();
  runApp( const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      title: 'Flutter Web Drawer Navigation',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/general': (context) => GeneralPage(),
        '/demand': (context) => DemandPage(),
        '/geography': (context) => GeographyPage(),
        '/skills': (context) => SkillsPage(),
        '/latest_vacancies': (context) => LatestVacanciesPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}