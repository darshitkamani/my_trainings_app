import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class HighlightView extends StatefulWidget {
  const HighlightView({super.key, required this.highlightCourseList, required this.height});
  final List<Session> highlightCourseList;
  final double height;

  @override
  State<HighlightView> createState() => _HighlightViewState();
}

class _HighlightViewState extends State<HighlightView> {
  // List of banner images to be used in the carousel
  List<String> bannerList = [
    AssetUtilities.trainingBanner1,
    AssetUtilities.trainingBanner2,
    AssetUtilities.trainingBanner3,
  ];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Button for navigating to the previous page in the carousel
        CarouselButton(
          icon: Icons.arrow_back_ios,
          onTap: () {
            if (pageController.page! > 0) {
              pageController.jumpToPage((pageController.page! - 1).toInt());
            } else {
              pageController.jumpToPage(widget.highlightCourseList.length - 1); // Loop to the last page if at the first
            }
          },
        ),
        // Expanded widget to take up available space for the PageView
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
                height: widget.height,
                width: VariableUtilities.screenSize.width,
                color: VariableUtilities.theme.blackColor,
                child: PageView.builder(
                    // PageView.builder creates a scrollable list of pages
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.highlightCourseList.length,
                    itemBuilder: (context, index) {
                      // Retrieve the session model for the current index
                      Session highlightCourseModel = widget.highlightCourseList[index];

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CustomImageView(imageUrl: bannerList[index % bannerList.length], height: widget.height, width: VariableUtilities.screenSize.width, boxFit: BoxFit.cover),

                          Container(
                            color: VariableUtilities.theme.blackColor.withValues(alpha: 0.6),
                          ),
                          // Main content of the carousel item (session details)
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(highlightCourseModel.sessionName, style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold)),
                                SizedBox(height: 10),
                                // City and date range display
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: highlightCourseModel.city,
                                      style: FontUtilities.h16(
                                        fontColor: VariableUtilities.theme.whiteColor,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: ' - ${dateFormatter(highlightCourseModel.fromDate)} - ${dateFormatter(highlightCourseModel.toDate)}',
                                            style: FontUtilities.h16(fontColor: VariableUtilities.theme.whiteColor))
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Text(highlightCourseModel.actualFees,
                                        style: FontUtilities.h10(
                                            decorationThickness: 3,
                                            decorationColor: VariableUtilities.theme.primaryColor,
                                            decoration: TextDecoration.lineThrough,
                                            fontColor: VariableUtilities.theme.primaryColor)),
                                    const SizedBox(width: 5),
                                    Text(highlightCourseModel.discountedFees, style: FontUtilities.h18(fontColor: VariableUtilities.theme.primaryColor, fontWeight: FWT.semiBold)),
                                    Spacer(),
                                    CustomTextButton(
                                        title: 'View Details',
                                        icon: Icons.arrow_forward,
                                        onTap: () {
                                          Navigator.pushNamed(context, RouteUtilities.trainingDetailsScreen, arguments: widget.highlightCourseList[index]);
                                        })
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    })),
          ),
        ),
        // Button for navigating to the next page in the carousel
        CarouselButton(
          icon: Icons.arrow_forward_ios,
          onTap: () {
            if (pageController.page! < widget.highlightCourseList.length - 1) {
              pageController.jumpToPage((pageController.page! + 1).toInt());
            } else {
              pageController.jumpToPage(0);
            }
          },
        )
      ],
    );
  }

  // Helper function to format dates in "dd MMM" format
  String dateFormatter(DateTime date) {
    return DateFormat('dd MMM').format(date).toUpperCase();
  }
}
