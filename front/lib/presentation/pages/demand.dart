import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class DemandPage extends StatelessWidget {
  static const String routeName = '/demand';

  const DemandPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Demand Page'),
      ),
      body: const Center(
        child: Text('General Screen'),
      ),
    );
  }
}

class DemandPageTexts{
  static const String pageName = 'Востребованность';
}