import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('General Screen'),
      ),
    );
  }
}

class HomePageTexts{
  static const String pageName = 'Главная';
}