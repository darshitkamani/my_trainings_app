import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/src/widget/divider/dotted_line_divider.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class TrainingItemView extends StatelessWidget {
  // Constructor to accept a session object
  const TrainingItemView({super.key, required this.session});
  final Session session;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteUtilities.trainingDetailsScreen, arguments: session);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: VariableUtilities.theme.whiteColor,
          boxShadow: [BoxShadow(offset: Offset(1, 1), blurRadius: 4, spreadRadius: -2, color: VariableUtilities.theme.blackColor.withValues(alpha: 0.6))],
        ),
        height: 190,
        width: VariableUtilities.screenSize.width,
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        returnDateWithMonthName(fromDate: session.fromDate, toDate: session.toDate),
                        style: FontUtilities.h18(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${session.fromTime} - ${session.toTime}',
                        style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.semiBold),
                      ),
                    ],
                  ),
                  Text(
                    "${session.place}, ${session.city}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold),
                  ),
                ],
              ),
            ),
            VerticalDashedDivider(height: 200, dashHeight: 5, dashWidth: 1.3, color: VariableUtilities.theme.silverColor),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    session.trainer.badge,
                    style: FontUtilities.h10(fontColor: VariableUtilities.theme.primaryColor, fontWeight: FWT.bold),
                  ),
                  Text(
                    session.training,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontUtilities.h18(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(AssetUtilities.profileIcon),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -5,
                            child: CircleAvatar(backgroundImage: AssetImage(AssetUtilities.companyLogo), radius: 10, backgroundColor: VariableUtilities.theme.greyColor),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          spacing: 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.trainer.skill,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FontUtilities.h13(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold),
                            ),
                            Text(
                              session.trainer.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FontUtilities.h13(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.semiBold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: VariableUtilities.theme.primaryColor, borderRadius: BorderRadius.circular(3)),
                        child: Text(
                          'Enroll Now',
                          style: FontUtilities.h16(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format date in "MMM dd yyyy" format
  String returnDateWithMonthName({required DateTime fromDate, required DateTime toDate}) {
    DateFormat dateFormat = DateFormat("MMM dd yyyy");

    String formattedFromDate = dateFormat.format(fromDate);
    String formattedToDate = dateFormat.format(toDate);

    return "${formattedFromDate.split(' ')[0]} ${formattedFromDate.split(' ')[1]}-${formattedToDate.split(' ')[1]} ${formattedToDate.split(' ')[2]}";
  }
}
