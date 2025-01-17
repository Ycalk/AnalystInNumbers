import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.hoverText,
    this.hovered = false,
    required this.onEnter,
    required this.onExit,
  });
  
  final void Function() onEnter;
  final void Function() onExit;
  final bool hovered;
  final String hoverText;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEnter(),
      onExit: (_) => onExit(),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                hoverText,
                style: TextStyles.description.copyWith(
                  color: hovered ? AppColors.primaryLight : Colors.transparent,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 10,),
          Text(
            text,
            style: TextStyles.description.copyWith(
              color: hovered ? AppColors.primary : TextStyles.description.color,
              fontSize: hovered ? 20 : TextStyles.description.fontSize,
            ),
          )
        ],
      ),
    );
  }
}