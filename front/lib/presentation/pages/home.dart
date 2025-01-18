import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/check_box_text.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:gif/gif.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.only(left: 100.0, right: 100, top: 60, bottom: 100),
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(HomePageTexts.introductionTitle, style: TextStyles.subtitle),
                                const SizedBox(height: 20),
                                SelectableText(HomePageTexts.introduction, style: TextStyles.description),
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
                          SelectableText(HomePageTexts.aboutTitle, style: TextStyles.subtitle),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(HomePageTexts.about, style: TextStyles.description),
                                ...HomePageTexts.aboutList.map<Widget>(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle, color: AppColors.primaryLight),
                                        const SizedBox(width: 10),
                                        SelectableText(item, style: TextStyles.description),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SelectableText(HomePageTexts.aboutFinal, style: TextStyles.description),
                              ],
                            )
                          ),
                          const SizedBox(width: 200,),
                          Flexible(
                            flex: 1,
                            child: Image.asset('assets/about.png')
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 100),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Gif(
                              autostart: Autostart.loop,
                              image: const AssetImage('assets/relevance.gif')
                            ),
                          ),
                          const SizedBox(width: 200),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(HomePageTexts.relevanceTitle, style: TextStyles.subtitle),
                                const SizedBox(height: 20),
                                SelectableText(HomePageTexts.relevance, style: TextStyles.description),
                              ],
                            ),
                          ),
                        ],
                      ),
            
                      const SizedBox(height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectableText(HomePageTexts.becomeTitle, style: TextStyles.subtitle),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText(HomePageTexts.become, style: TextStyles.description),
                                    ...HomePageTexts.becomeList.map<Widget>(
                                      (item) => Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: CheckBoxText(text: item),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              const SizedBox(width: 200,),
                              Flexible(
                                flex: 1,
                                child: Image.asset('assets/become.png'),
                              ),
                            ],
                          )
                        ],
                      ),
            
                      const SizedBox(height: 100),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryLight,
                        ),
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SelectableText(HomePageTexts.future, style: TextStyles.subtitle.copyWith(color: Colors.white)),
                            const SizedBox(height: 20),
                            SelectableText(HomePageTexts.futureText, style: TextStyles.description.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ),

            const Footer(),
          ],
        )
      )
    );
  }
}

class HomePageTexts{
  static const String pageName = 'Главная';
  
  static const String introductionTitle = 'Аналитик в цифрах';
  static const String introduction = 'В современном мире, данных больше, чем когда-либо. Компании по всему миру ежедневно сталкиваются с необходимостью извлечения полезной информации из огромных массивов данных. Аналитики играют ключевую роль в этом процессе, превращая сырые данные в понятные и применимые решения. От маркетинга до финансов, от технологий до здравоохранения – аналитики востребованы во всех отраслях.';

  static const String aboutTitle = 'Кто такой аналитик и что он делает?';
  static final List<String> aboutList = [
    'Сбор и обработка данных из различных источников',
    'Выявление ключевых метрик и трендов',
    'Построение моделей и прогнозирование результатов',
    'Подготовка отчетов и визуализаций',
    'Рекомендации для бизнеса на основе полученных данных',
  ];
  static const String about = "Аналитик – это профессионал, который анализирует данные, выявляет закономерности и помогает принимать обоснованные решения. Среди основных задач аналитика:";
  static const String aboutFinal = "Будь то бизнес-аналитика, финансовый анализ или анализ пользовательского поведения, этот специалист всегда находится в центре принятия стратегических решений.";

  static const String relevanceTitle = "Почему профессия аналитика актуальна?";
  static const String relevance = 'Мир быстро меняется, и данные становятся новой "валютой". В условиях цифровой трансформации компании ищут специалистов, способных работать с большими данными и находить в них ценную информацию. Рост количества данных создает растущий спрос на аналитиков, а необходимость улучшения процессов, сокращения издержек и повышения эффективности делает эту профессию одной из самых востребованных.';

  static const String becomeTitle = 'Как стать аналитиком?';
  static const String become = 'Для того чтобы стать аналитиком, не обязательно иметь диплом по аналитике. Большинство специалистов начинают с освоения ключевых навыков:';
  static final List<String> becomeList = [
    'Основы статистики и теории вероятностей',
    'Знание языков программирования (Python, R, SQL)',
    'Умение работать с базами данных',
    'Развитое аналитическое мышление',
    'Знание инструментов визуализации данных (Tableau, Power BI)',
  ];

  static const String future = 'Будущее аналитики';
  static const String futureText = 'С каждым годом появляются новые инструменты, методики и подходы к анализу данных. Искусственный интеллект, машинное обучение, облачные технологии – все это расширяет возможности аналитиков. Те, кто уже сегодня изучают эти технологии, завтра будут формировать будущее.';
}