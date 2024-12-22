import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.titleStyle,
      this.icon});
  final VoidCallback onTap;
  final String title;
  final TextStyle? titleStyle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          spacing: 5,
          children: [
            Text(title,
                style: titleStyle ??
                    FontUtilities.h14(
                        fontColor: VariableUtilities.theme.whiteColor)),
            icon != null
                ? Icon(
                    icon,
                    color: VariableUtilities.theme.whiteColor,
                  )
                : const SizedBox()
          ],
        ));
  }
}
