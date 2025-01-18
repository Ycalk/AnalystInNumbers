import 'package:flutter/material.dart';
import 'package:front/domain/usecases/profession_stats.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:front/presentation/widgets/drawer.dart';
import 'package:front/presentation/widgets/footer.dart';
import 'package:front/presentation/widgets/future_loader.dart';
import 'package:front/presentation/widgets/key_skills_info.dart';

class SkillsPage extends StatelessWidget {
  static const String routeName = '/skills';
  final ProfessionStats professionStats = ProfessionStats();
  
  SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Analyst Skills'),
        backgroundColor: AppColors.tertiary,
        surfaceTintColor: AppColors.tertiary,
      ),
      body: FutureLoader(future: professionStats.getSkillsByYear(), 
        builder: (skillsByYear) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60,),
                      SelectableText(
                        'ТОП-20 навыков по годам (Аналитик)',
                        style: TextStyles.subtitle,
                      ),
                      const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: KeySkillsInfo(data: skillsByYear,),
                      ),
                    ],
                  )
                ),

                const SizedBox(height: 100,),
                const Footer()
              ],
            )
          );
        },
      ),
    );
  }
}

class SkillsPageTexts{
  static const String pageName = 'Навыки';
}