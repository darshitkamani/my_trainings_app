import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String text;
  final double? iconSize;

  const InfoRow({
    super.key,
    this.icon,
    required this.text,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon != null
              ? Row(
                  children: [
                    Icon(icon,
                        color: VariableUtilities.theme.whiteColor,
                        size: iconSize ?? 20),
                    const SizedBox(width: 10),
                  ],
                )
              : const SizedBox(),
          Expanded(
            child: Text(
              text,
              style: FontUtilities.h15(
                  fontColor: VariableUtilities.theme.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
