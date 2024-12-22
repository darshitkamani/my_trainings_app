import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1.5,
                    color: VariableUtilities.theme.greyColor
                        .withValues(alpha: 0.6))),
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomImageView(
                    imageUrl: AssetUtilities.filterIcon,
                    color: VariableUtilities.theme.greyColor,
                    height: 14,
                    width: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Filter',
                    style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.greyColor,
                        fontWeight: FWT.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
