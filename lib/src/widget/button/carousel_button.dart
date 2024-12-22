import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class CarouselButton extends StatelessWidget {
  const CarouselButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 25,
        color: VariableUtilities.theme.blackColor.withValues(alpha: 0.4),
        child: Center(
            child: Icon(icon,
                color: VariableUtilities.theme.whiteColor, size: 18)),
      ),
    );
  }
}
