import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/model/filter_model.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class TrainingNameFilterView extends StatefulWidget {
  const TrainingNameFilterView({super.key, required this.filterProvider});

  final FilterProvider filterProvider;

  @override
  State<TrainingNameFilterView> createState() => _TrainingNameFilterViewState();
}

class _TrainingNameFilterViewState extends State<TrainingNameFilterView> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    // Clears the previous search result when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.filterProvider.searchTrainingList = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    // Cancels the debounce timer when the widget is disposed
    _debounce?.cancel();
    super.dispose();
  }

  // Builds the list of training names with checkboxes for selection
  Widget buildTrainingNameList(List<BaseModel> trainingsList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingsList.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        BaseModel training = trainingsList[index];
        return CheckboxListTile(
          activeColor: VariableUtilities.theme.primaryColor,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            training.name,
            style: FontUtilities.h16(
              fontColor: VariableUtilities.theme.blackColor,
              fontWeight: widget.filterProvider.selectedTrainingList.contains(training) ? FWT.bold : FWT.semiBold,
            ),
          ),
          value: widget.filterProvider.selectedTrainingList.contains(training),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (val) {
            widget.filterProvider.addOrRemoveTrainingToTrainingList(training);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search input field for filtering training names
        SearchInputField(
          searchController: searchController,
          onChanged: (val) {
            // Debounces the input to avoid frequent search calls
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }
            _debounce = Timer(const Duration(milliseconds: 300), () {
              widget.filterProvider.onTrainingSearch(val);
            });
          },
        ),
        // Displays the filtered list or a "no results" message
        searchController.text.isEmpty && widget.filterProvider.searchTrainingList.isEmpty
            ? buildTrainingNameList(widget.filterProvider.trainingList)
            : widget.filterProvider.searchTrainingList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'No search data found related to "${searchController.text}"',
                        style: FontUtilities.h16(
                          fontColor: VariableUtilities.theme.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                  )
                : buildTrainingNameList(widget.filterProvider.searchTrainingList),
      ],
    );
  }
}
