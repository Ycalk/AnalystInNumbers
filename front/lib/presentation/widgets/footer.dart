import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SelectableText('Analyst In Numbers', style: TextStyles.subtitle.copyWith(color: Colors.white)),
            SelectableText('Лосев Алексей Ярославович, АТ-22', style: TextStyles.description.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}