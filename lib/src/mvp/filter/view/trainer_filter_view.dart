import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/model/filter_model.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class TrainersFilterView extends StatefulWidget {
  const TrainersFilterView({super.key, required this.filterProvider});

  final FilterProvider filterProvider;

  @override
  State<TrainersFilterView> createState() => _TrainersFilterViewState();
}

class _TrainersFilterViewState extends State<TrainersFilterView> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // Clear previous search results after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.filterProvider.searchTrainersList = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    // Cancel debounce timer when the widget is disposed
    _debounce?.cancel();
    super.dispose();
  }

  // Builds the list of trainers with checkboxes
  Widget buildTrainersList(List<Trainer> trainersList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainersList.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        Trainer trainer = trainersList[index];
        return CheckboxListTile(
          activeColor: VariableUtilities.theme.primaryColor,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            trainer.name,
            style: FontUtilities.h16(
              fontColor: VariableUtilities.theme.blackColor,
              fontWeight: widget.filterProvider.selectedTrainersList.contains(trainer) ? FWT.bold : FWT.semiBold,
            ),
          ),
          value: widget.filterProvider.selectedTrainersList.contains(trainer),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (val) {
            widget.filterProvider.addOrRemoveTrainersToTrainersList(trainer);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search input field for trainer search
        SearchInputField(
          searchController: searchController,
          onChanged: (val) {
            // Debounce search input to reduce unnecessary calls
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }
            _debounce = Timer(const Duration(milliseconds: 300), () {
              widget.filterProvider.onTrainersSearch(val); // Trigger search
            });
          },
        ),
        // Display either trainers list or search results based on input
        searchController.text.isEmpty && widget.filterProvider.searchTrainersList.isEmpty
            ? buildTrainersList(widget.filterProvider.trainersList)
            : widget.filterProvider.searchTrainersList.isEmpty
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
                : buildTrainersList(widget.filterProvider.searchTrainersList),
      ],
    );
  }
}
