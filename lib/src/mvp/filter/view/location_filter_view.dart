import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/model/filter_model.dart';
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class LocationFilterView extends StatefulWidget {
  const LocationFilterView({super.key, required this.filterProvider});

  final FilterProvider filterProvider;

  @override
  State<LocationFilterView> createState() => _LocationFilterViewState();
}

class _LocationFilterViewState extends State<LocationFilterView> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // Clear previous search results after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.filterProvider.searchLocationList = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    // Cancel debounce timer when the widget is disposed
    _debounce?.cancel();
    super.dispose();
  }

  // Builds the list of locations with checkboxes
  Widget buildLocationList(List<BaseModel> locations) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: locations.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        BaseModel location = locations[index];
        return CheckboxListTile(
          activeColor: VariableUtilities.theme.primaryColor,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            location.name,
            style: FontUtilities.h16(
              fontColor: VariableUtilities.theme.blackColor,
              fontWeight: widget.filterProvider.selectedLocationList.contains(location)
                  ? FWT.bold //
                  : FWT.semiBold,
            ),
          ),
          value: widget.filterProvider.selectedLocationList.contains(location),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (val) {
            widget.filterProvider.addOrRemoveLocationToLocationList(location);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search input field for location search
        SearchInputField(
          searchController: searchController,
          onChanged: (val) {
            // Debounce search input to reduce unnecessary calls
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }
            _debounce = Timer(const Duration(milliseconds: 300), () {
              widget.filterProvider.onLocationSearch(val); // Trigger search
            });
          },
        ),
        // Display either location list or search results based on input
        searchController.text.isEmpty && widget.filterProvider.searchLocationList.isEmpty
            ? buildLocationList(widget.filterProvider.locationList)
            : widget.filterProvider.searchLocationList.isEmpty
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
                : buildLocationList(widget.filterProvider.searchLocationList),
      ],
    );
  }
}
