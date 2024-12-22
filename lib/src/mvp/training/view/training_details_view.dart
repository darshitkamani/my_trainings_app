import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/src/mvp/training/view/info_raw.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class TrainingDetailsView extends StatefulWidget {
  const TrainingDetailsView({super.key, required this.session});

  final Session session;

  @override
  State<TrainingDetailsView> createState() => _TrainingDetailsViewState();
}

class _TrainingDetailsViewState extends State<TrainingDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.blackColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: VariableUtilities.theme.whiteColor)),
        backgroundColor: VariableUtilities.theme.blackColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CustomImageView(
                    imageUrl: AssetUtilities.trainingBanner1,
                    width: VariableUtilities.screenSize.width,
                    height: 210,
                  ),
                ),
                Container(
                  color: VariableUtilities.theme.blackColor.withValues(alpha: 0.4),
                  width: VariableUtilities.screenSize.width,
                  height: 210,
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Icon(Icons.play_arrow, size: 40, color: VariableUtilities.theme.whiteColor),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Text(
                      'Preview This Course',
                      style: FontUtilities.h18(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
                    ),
                  ),
                )
              ]),
              SizedBox(height: 15),
              Text(
                widget.session.sessionName,
                style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor),
              ),
              SizedBox(height: 10),
              Text(
                widget.session.shortDescription,
                style: FontUtilities.h14(fontColor: VariableUtilities.theme.whiteColor),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${widget.session.ratings}', style: FontUtilities.h15(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold)),
                  SizedBox(width: 10),
                  RatingStars(
                    axis: Axis.horizontal,
                    value: widget.session.ratings,
                    onValueChanged: (v) {},
                    starCount: 5,
                    starSize: 20,
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: true,
                    valueLabelVisibility: false,
                    animationDuration: const Duration(milliseconds: 1000),
                    valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.amber,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '(${formatNumberWithCommas(widget.session.totalReviews)} Ratings) ${formatNumberWithCommas(widget.session.students)} Students',
                style: FontUtilities.h14(fontColor: VariableUtilities.theme.whiteColor),
              ),
              SizedBox(height: 15),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: ' ${widget.session.createdBy}',
                    style: FontUtilities.h16(fontColor: VariableUtilities.theme.primaryColor, fontWeight: FWT.bold),
                  )
                ],
                text: 'Created by',
                style: FontUtilities.h15(fontColor: VariableUtilities.theme.whiteColor),
              )),
              SizedBox(height: 10),
              // InfoRow(icon: Icons.info, text: 'Last updated 7/2024'),
              InfoRow(icon: Icons.public, text: widget.session.language.join(', ')),
              InfoRow(icon: Icons.closed_caption, text: widget.session.subtitles.join(', ')),
              SizedBox(height: 15),
              Text(
                widget.session.discountedFees,
                style: FontUtilities.h22(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
              ),
              SizedBox(height: 10),
              PrimaryButton(
                onTap: () {},
                title: 'Book Session',
                borderRadius: 0,
                height: 55,
                width: VariableUtilities.screenSize.width,
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              Text(
                'What you\'ll learn',
                style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
              ),
              SizedBox(height: 15),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.session.learningKeyPoints.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InfoRow(icon: Icons.check, text: widget.session.learningKeyPoints[index]);
                  }),
              Text(
                'This course includes',
                style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
              ),
              SizedBox(height: 15),
              InfoRow(icon: Icons.ondemand_video_outlined, text: '3 total hours on-demand video'),
              InfoRow(icon: Icons.file_copy_sharp, text: 'Support Files'),
              InfoRow(icon: Icons.all_inclusive, text: 'Full lifetime access'),
              InfoRow(icon: Icons.mobile_friendly_outlined, text: 'Access on mobile, desktop, and TV'),
              InfoRow(icon: Icons.workspace_premium, text: 'Certificate of Completion'),
              SizedBox(height: 20),
              Text(
                'Requirements',
                style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
              ),
              SizedBox(height: 15),
              InfoRow(text: '• Mac, PC or Linux'),
              InfoRow(text: '• Text Editor'),
              SizedBox(height: 10),
              Text(
                'Description',
                style: FontUtilities.h20(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.bold),
              ),
              SizedBox(height: 15),
              HtmlWidget(
                widget.session.description,
                textStyle: FontUtilities.h13(fontColor: VariableUtilities.theme.whiteColor),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

// Function to format a number with commas
  String formatNumberWithCommas(int number) {
    final NumberFormat numberFormat = NumberFormat("#,###");

    return numberFormat.format(number);
  }
}
