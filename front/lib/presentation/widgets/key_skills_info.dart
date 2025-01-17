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
    final rowsCount = (data.skillsData.length ~/ cardsInRow) + (data.skillsData.length % cardsInRow == 0 ? 0 : 1);
    return Column(
      children: List.generate(rowsCount,
        (rowCount) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(cardsInRow, 
              (index) {
                final currentIndex = rowCount * cardsInRow + index;
                if (currentIndex < data.skillsData.length){
                  final currentData = data.skillsData[rowCount * cardsInRow + index];
                  return YearSkillsCard(year: currentData.year, skills: currentData.skills);
                }
                return const SizedBox.shrink();
              },
            )
          );
        },
      )
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
          Text(
            year,
            style: TextStyles.subtitle,
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(skills.length ~/ 2, 
                  (index) {
                    return RichText (
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (index + 1).toString(),
                            style: TextStyles.subtitle.copyWith(color: AppColors.primaryLight)
                          ),
                          TextSpan(
                            text: '  ${skills[index]}',
                            style: TextStyles.description
                          ),
                        ]
                      )
                    );
                  },
                )
              ),
              const SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(skills.length ~/ 2, 
                  (index) {
                    index+=10;
                    return RichText (
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (index + 1).toString(),
                            style: TextStyles.subtitle.copyWith(color: AppColors.primaryLight)
                          ),
                          TextSpan(
                            text: '  ${skills[index]}',
                            style: TextStyles.description
                          ),
                        ]
                      )
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