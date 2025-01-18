import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class CheckBoxText extends StatefulWidget {
  final String text;
  const CheckBoxText({super.key, required this.text});

  @override
  State<CheckBoxText> createState() => _CheckBoxTextState();
}

class _CheckBoxTextState extends State<CheckBoxText> {
  bool isChecked = false;
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              MSHCheckbox(
                size: 20,
                value: isChecked,
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: AppColors.primaryLight,
                ),
                style: MSHCheckboxStyle.stroke,
                onChanged: (selected) {
                  setState(() {
                    isChecked = selected;
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(widget.text, 
                style: TextStyles.description.copyWith(
                  decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                  color: hovered ? AppColors.primaryLight : TextStyles.description.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}