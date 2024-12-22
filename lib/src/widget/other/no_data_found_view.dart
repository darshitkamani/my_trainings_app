import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class NoDataFoundView extends StatelessWidget {
  const NoDataFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          LottieBuilder.asset(AssetUtilities.noDataFoundJson),
          Text(
            "No Trainings Found To Related Filers!",
            textAlign: TextAlign.center,
            style: FontUtilities.h20(
                fontColor: VariableUtilities.theme.blackColor,
                fontWeight: FWT.semiBold),
          ),
        ],
      ),
    );
  }
}
