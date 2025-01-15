import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class GeographyPage extends StatelessWidget {
  static const String routeName = '/geography';
  
  const GeographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Geography'),
      ),
      body: const Center(
        child: Text('Geography Page'),
      ),
    );
  }
}

class GeographyPageTexts{
  static const String pageName = 'География';
}