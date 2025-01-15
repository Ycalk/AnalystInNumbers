import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class SkillsPage extends StatelessWidget {
  static const String routeName = '/skills';
  
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Skills'),
      ),
      body: const Center(
        child: Text('Skills Page'),
      ),
    );
  }
}

class SkillsPageTexts{
  static const String pageName = 'Навыки';
}