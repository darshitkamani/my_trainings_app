import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/mvp/filter/view/location_filter_view.dart';
import 'package:my_trainings_app/src/mvp/filter/view/trainer_filter_view.dart';
import 'package:my_trainings_app/src/mvp/filter/view/training_name_filter_view.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

// FilterBottomSheet widget is used to display filters for sorting and selecting training details.
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, required this.isFromFilterView});
  final bool isFromFilterView; // Determines if the view is accessed from the filter screen.

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (_, filterProvider, __) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).viewInsets.bottom > 0 ? 350 : 550,
            color: VariableUtilities.theme.whiteColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sort and Filters',
                        style: FontUtilities.h22(
                          fontColor: VariableUtilities.theme.blackColor,
                          fontWeight: FWT.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet when the close button is tapped.
                        },
                        icon: Icon(
                          Icons.close_outlined,
                          color: VariableUtilities.theme.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: VariableUtilities.theme.offWhiteColor,
                  width: VariableUtilities.screenSize.width,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // List of sort and filter options on the left side.
                      SingleChildScrollView(
                        child: SizedBox(
                          width: 165,
                          child: ListView.builder(
                            itemCount: filterProvider.sortAndFiltersList.length, //
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              String sortAndFilter = filterProvider.sortAndFiltersList[index];
                              return InkWell(
                                onTap: () {
                                  filterProvider.selectedSortAndFilter = sortAndFilter;
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: VariableUtilities.theme.offWhiteColor,
                                      ),
                                      left: BorderSide(
                                        width: 6,
                                        color: filterProvider.selectedSortAndFilter == sortAndFilter ? VariableUtilities.theme.primaryColor : Colors.transparent,
                                      ),
                                    ),
                                    color: filterProvider.selectedSortAndFilter == sortAndFilter ? VariableUtilities.theme.whiteColor : VariableUtilities.theme.offWhiteColor,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        sortAndFilter,
                                        style: FontUtilities.h18(
                                          fontColor: VariableUtilities.theme.blackColor,
                                          fontWeight: filterProvider.selectedSortAndFilter == sortAndFilter ? FWT.bold : FWT.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Content for the selected filter shown on the right.
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: filterProvider.selectedSortAndFilter == Constant.sortBy
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'We\'ll Implement this feature  in Future.',
                                        style: FontUtilities.h16(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.semiBold),
                                      ),
                                    ),
                                  )
                                : filterProvider.selectedSortAndFilter == Constant.location
                                    ? LocationFilterView(filterProvider: filterProvider)
                                    : filterProvider.selectedSortAndFilter == Constant.trainingName
                                        ? TrainingNameFilterView(filterProvider: filterProvider)
                                        : filterProvider.selectedSortAndFilter == Constant.trainer
                                            ? TrainersFilterView(filterProvider: filterProvider)
                                            : const SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer with Clear and Apply buttons.
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: PrimaryButton(
                              titleColor: VariableUtilities.theme.primaryColor,
                              color: Colors.white,
                              onTap: () {
                                filterProvider.clearFilters(context); //
                              },
                              title: 'Clear Filter')),
                      SizedBox(width: 10),
                      Expanded(
                          child: PrimaryButton(
                              onTap: () {
                                filterProvider.sortAndFilter(context);

                                if (widget.isFromFilterView) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, RouteUtilities.filterScreen);
                                }
                              },
                              title: 'Show Result'))
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      );
    });
  }
}
