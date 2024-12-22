import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

///Primary button
class PrimaryButton extends StatelessWidget {
  ///Constructor Primary button

  const PrimaryButton({
    required this.onTap,
    required this.title,
    this.height,
    this.width,
    this.centerWidget,
    this.color,
    this.titleColor,
    this.borderColor,
    this.textStyle,
    this.borderRadius,
    super.key,
  });

  ///call back for button
  final VoidCallback onTap;

  ///Button height
  final double? height;

  ///Button width
  final double? width;

  ///Button color
  final Color? color;

  ///Button title color
  final Color? titleColor;

  ///Button Border color
  final Color? borderColor;

  ///Button title
  final String title;

  ///Text style
  final TextStyle? textStyle;

  final Widget? centerWidget;

  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height ?? 45,
      minWidth: width ?? 222,
      color: color ?? VariableUtilities.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        side: BorderSide(
            color: borderColor ?? VariableUtilities.theme.primaryColor,
            width: 1),
      ),
      child: centerWidget ??
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle ??
                FontUtilities.h16(
                    fontColor: titleColor ?? VariableUtilities.theme.whiteColor,
                    fontWeight: FWT.semiBold),
          ),
    );
  }
}
