import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 100),
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(HomePageTexts.introductionTitle, style: TextStyles.subtitle),
                    const SizedBox(height: 20),
                    Text(HomePageTexts.introduction, style: TextStyles.description),
                  ],
                ),
              ),
              const SizedBox(width: 200),
              Flexible(
                flex: 1,
                child: Image.asset('assets/introduction.png')
              ),
            ],
          ),
          const SizedBox(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(HomePageTexts.aboutTitle, style: TextStyles.subtitle),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: HomePageTexts.aboutList.map<Widget>(
                    (item) => Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: AppColors.primaryLight),
                          const SizedBox(width: 10),
                          Text(item, style: TextStyles.description),
                        ],
                      ),
                    )
                  ).toList()..insert(0, Text(HomePageTexts.about, style: TextStyles.description),),
                ),
              ),
              const SizedBox(width: 200,),
              Flexible(
                flex: 1,
                child: Image.asset('assets/about.png')
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePageTexts{
  static const String pageName = 'Главная';
  
  static const String introductionTitle = 'Аналитик в цифрах';
  static const String introduction = 'В современном мире данных больше, чем когда-либо. Компании по всему миру ежедневно сталкиваются с необходимостью извлечения полезной информации из огромных массивов данных. Аналитики играют ключевую роль в этом процессе, превращая сырые данные в понятные и применимые решения. От маркетинга до финансов, от технологий до здравоохранения – аналитики востребованы во всех отраслях.';

  static const String aboutTitle = 'Кто такой аналитик и что он делает';
  static final List<String> aboutList = [
    'Сбор и обработка данных из различных источников',
    'Выявление ключевых метрик и трендов',
    'Построение моделей и прогнозирование результатов',
    'Подготовка отчетов и визуализаций',
    'Рекомендации для бизнеса на основе полученных данных',
  ];
  static const String about = "Аналитик – это профессионал, который анализирует данные, выявляет закономерности и помогает принимать обоснованные решения. Среди основных задач аналитика:";
}