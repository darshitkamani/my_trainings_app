import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/mvp/filter/view/filter_bottom_sheet.dart';
import 'package:my_trainings_app/src/mvp/training/view/training_item_view.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, FilterProvider filterProvider, __) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigates back when pressed
              },
              icon: Icon(Icons.arrow_back, color: VariableUtilities.theme.whiteColor)),
          title: Text(
            'Trainings',
            style: FontUtilities.h26(
              letterSpacing: 1.5,
              fontFamily: 'Playfair Display',
              fontColor: VariableUtilities.theme.whiteColor,
              fontWeight: FWT.extraBold,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: VariableUtilities.theme.primaryColor,
        ),
        body: Column(
          children: [
            // Filter bar
            Container(
              color: VariableUtilities.theme.primaryColor,
              height: 75,
              width: VariableUtilities.screenSize.width,
              child: ListView.builder(
                  itemCount: filterProvider.trainingFilterList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              // Show filter bottom sheet when 'Filter' is tapped
                              if (filterProvider.trainingFilterList[index].name == 'Filter') {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: Border.all(),
                                    builder: (_) {
                                      return SingleChildScrollView(child: FilterBottomSheet(isFromFilterView: true));
                                    });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: filterProvider.trainingFilterList[index] == filterProvider.selectedTrainingFilterModel
                                      ? VariableUtilities.theme.whiteColor
                                      : VariableUtilities.theme.blackColor.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Icon(
                                        filterProvider.trainingFilterList[index].icon,
                                        color: filterProvider.trainingFilterList[index] == filterProvider.selectedTrainingFilterModel
                                            ? VariableUtilities.theme.primaryColor
                                            : VariableUtilities.theme.whiteColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        filterProvider.trainingFilterList[index].name,
                                        style: FontUtilities.h14(
                                            fontWeight: FWT.semiBold,
                                            fontColor: filterProvider.trainingFilterList[index] == filterProvider.selectedTrainingFilterModel
                                                ? VariableUtilities.theme.primaryColor
                                                : VariableUtilities.theme.whiteColor),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            // Displaying filtered results or no data
            Expanded(
              child: filterProvider.filteredList.isEmpty
                  ? NoDataFoundView() // Show no data if filtered list is empty
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filterProvider.filteredList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: TrainingItemView(session: filterProvider.filteredList[index]),
                              );
                            }),
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}
