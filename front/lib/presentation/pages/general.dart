import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class GeneralPage extends StatelessWidget {
  static const String routeName = '/general';

  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('General'),
      ),
      body: Center(
        child: Text('General Screen'),
      ),
    );
  }
}

class GeneralPageTexts{
  static const String pageName = 'Общая статистика';
}