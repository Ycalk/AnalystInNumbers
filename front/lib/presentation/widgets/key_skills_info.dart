import 'package:flutter/material.dart';
import 'package:front/domain/entities/skills_data.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class KeySkillsInfo extends StatelessWidget {
  static const cardsInRow = 2;
  final SkillsData data;
  const KeySkillsInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(data.skillsData.length, (index) {
          return YearSkillsCard(
            year: data.skillsData[index].year, 
            skills: data.skillsData[index].skills  
          );
        }),
      ),
    );
  }
}

class YearSkillsCard extends StatelessWidget {
  final String year;
  final List<String> skills;
  const YearSkillsCard({super.key, required this.year, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.lerp(AppColors.onTertiaryLight, AppColors.tertiary, 0.95),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          SelectableText(
            year,
            style: TextStyles.subtitle,
          ),
          const SizedBox(height: 20,),
          Wrap(
            spacing: 30.0,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(skills.length ~/ 2, 
                  (index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          (index + 1).toString(),
                          style: TextStyles.subtitle.copyWith(color: AppColors.primaryLight)
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SelectableText(
                            skills[index],
                            style: TextStyles.description
                          ),
                        )
                      ],
                    );
                  },
                )
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(skills.length ~/ 2, 
                  (index) {
                    index+=10;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          (index + 1).toString(),
                          style: TextStyles.subtitle.copyWith(color: AppColors.primaryLight)
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SelectableText(
                            skills[index],
                            style: TextStyles.description
                          ),
                        )
                      ],
                    );
                  },
                )
              ),
            ],
          )
        ]
      ),
    );
  }
}