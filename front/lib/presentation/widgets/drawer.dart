import 'package:flutter/material.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/pages/demand.dart';
import 'package:front/presentation/pages/general.dart';
import 'package:front/presentation/pages/geography.dart';
import 'package:front/presentation/pages/home.dart';
import 'package:front/presentation/pages/latest_vacancies.dart';
import 'package:front/presentation/pages/skills.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  
  static const List<(String, String)> pages = [
    (HomePageTexts.pageName, HomePage.routeName),
    (GeneralPageTexts.pageName, GeneralPage.routeName),
    (DemandPageTexts.pageName, DemandPage.routeName),
    (GeographyPageTexts.pageName, GeographyPage.routeName),
    (SkillsPageTexts.pageName, SkillsPage.routeName),
    (LatestVacanciesPageTexts.pageName, LatestVacanciesPage.routeName),
  ];

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(Texts.appName, style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ...pages.map((page) {
            return ListTile(
              title: Text(page.$1),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, page.$2);
              },
            );
          }),
        ],
      ),
    );
  }
}