import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class DemandPage extends StatelessWidget {
  static const String routeName = '/demand';

  const DemandPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Demand Page'),
      ),
      body: Center(
        child: Text('General Screen'),
      ),
    );
  }
}

class DemandPageTexts{
  static const String pageName = 'Востребованность';
}