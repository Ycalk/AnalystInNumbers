import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class GeographyPage extends StatelessWidget {
  static const String routeName = '/geography';
  
  const GeographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Geography'),
      ),
      body: Center(
        child: Text('Geography Page'),
      ),
    );
  }
}

class GeographyPageTexts{
  static const String pageName = 'География';
}