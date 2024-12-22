import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trainings_app/src/mvp/filter/model/filter_model.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_filter_model.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/src/mvp/training/provider/training_provider.dart';
import 'package:my_trainings_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

class FilterProvider extends ChangeNotifier {
  // List of predefined training filter options
  List<TrainingFilterModel> trainingFilterList = [
    TrainingFilterModel(name: 'Filter', icon: Icons.sort),
    TrainingFilterModel(name: 'Near me', icon: Icons.search),
    TrainingFilterModel(name: 'Filling Fast', icon: Icons.search),
    TrainingFilterModel(name: 'This Month', icon: Icons.search),
    TrainingFilterModel(name: 'Early Bird', icon: Icons.search)
  ];

  // Currently selected training filter
  TrainingFilterModel _selectedTrainingFilterModel = TrainingFilterModel(name: 'Filter', icon: Icons.sort);
  TrainingFilterModel get selectedTrainingFilterModel => _selectedTrainingFilterModel;
  set selectedTrainingFilterModel(TrainingFilterModel val) {
    _selectedTrainingFilterModel = val;
    notifyListeners(); // Notify listeners of changes
  }

  // List of sort and filter criteria
  List<String> sortAndFiltersList = [Constant.sortBy, Constant.location, Constant.trainingName, Constant.trainer];

  // Currently selected sort and filter criterion
  String _selectedSortAndFilter = Constant.location;
  String get selectedSortAndFilter => _selectedSortAndFilter;
  set selectedSortAndFilter(String val) {
    _selectedSortAndFilter = val;
    notifyListeners();
  }

  // Initialize the filter provider by loading data from JSON asset
  Future init() async {
    FilterModel filterModel = await loadJsonAsset();
    locationList = filterModel.locations;
    trainingList = filterModel.trainings;
    trainersList = filterModel.trainers;
  }

  // Load filter data from a JSON file
  Future<FilterModel> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString(AssetUtilities.filterDataJson);
    FilterModel filterModel = FilterModel.fromJson(jsonDecode(jsonString));
    return filterModel;
  }

  // List of locations loaded from the JSON file
  List<BaseModel> locationList = [];

  // Selected locations
  List<BaseModel> _selectedLocationList = [];
  List<BaseModel> get selectedLocationList => _selectedLocationList;
  set selectedLocationList(List<BaseModel> val) {
    _selectedLocationList = val;
    notifyListeners();
  }

  // List of locations matching the search query
  List<BaseModel> _searchLocationList = [];
  List<BaseModel> get searchLocationList => _searchLocationList;
  set searchLocationList(List<BaseModel> val) {
    _searchLocationList = val;
    notifyListeners();
  }

  // Add or remove a location from the selected list
  void addOrRemoveLocationToLocationList(BaseModel location) {
    if (selectedLocationList.contains(location)) {
      selectedLocationList.remove(location);
    } else {
      selectedLocationList.add(location);
    }
    notifyListeners();
  }

  // Update the search list based on the location query
  void onLocationSearch(String location) {
    if (location.isEmpty) {
      searchLocationList = [];
      notifyListeners();
      return;
    }
    searchLocationList = locationList.where((e) => e.name.toLowerCase().contains(location.toLowerCase())).toList();
    notifyListeners();
  }

  // List of trainings loaded from the JSON file
  List<BaseModel> trainingList = [];

  // Selected trainings
  List<BaseModel> _selectedTrainingList = [];
  List<BaseModel> get selectedTrainingList => _selectedTrainingList;
  set selectedTrainingList(List<BaseModel> val) {
    _selectedTrainingList = val;
    notifyListeners();
  }

  // List of trainings matching the search query
  List<BaseModel> _searchTrainingList = [];
  List<BaseModel> get searchTrainingList => _searchTrainingList;
  set searchTrainingList(List<BaseModel> val) {
    _searchTrainingList = val;
    notifyListeners();
  }

  // Add or remove a training from the selected list
  void addOrRemoveTrainingToTrainingList(BaseModel training) {
    if (selectedTrainingList.contains(training)) {
      selectedTrainingList.remove(training);
    } else {
      selectedTrainingList.add(training);
    }
    notifyListeners();
  }

  // Update the search list based on the training query
  void onTrainingSearch(String training) {
    if (training.isEmpty) {
      searchTrainingList = [];
      notifyListeners();
      return;
    }
    searchTrainingList = trainingList.where((e) => e.name.toLowerCase().contains(training.toLowerCase())).toList();
    notifyListeners();
  }

  // List of trainers loaded from the JSON file
  List<Trainer> trainersList = [];

  // Selected trainers
  List<Trainer> _selectedTrainersList = [];
  List<Trainer> get selectedTrainersList => _selectedTrainersList;
  set selectedTrainersList(List<Trainer> val) {
    _selectedTrainersList = val;
    notifyListeners();
  }

  // List of trainers matching the search query
  List<Trainer> _searchTrainersList = [];
  List<Trainer> get searchTrainersList => _searchTrainersList;
  set searchTrainersList(List<Trainer> val) {
    _searchTrainersList = val;
    notifyListeners();
  }

  // Add or remove a trainer from the selected list
  void addOrRemoveTrainersToTrainersList(Trainer trainers) {
    if (selectedTrainersList.contains(trainers)) {
      selectedTrainersList.remove(trainers);
    } else {
      selectedTrainersList.add(trainers);
    }
    notifyListeners();
  }

  // Update the search list based on the trainers query
  void onTrainersSearch(String trainers) {
    if (trainers.isEmpty) {
      searchTrainersList = [];
      notifyListeners();
      return;
    }
    searchTrainersList = trainersList.where((e) => e.name.toLowerCase().contains(trainers.toLowerCase())).toList();
    notifyListeners();
  }

  // Complete list of sessions (before filters are applied)
  List<Session> _filterList = [];
  List<Session> get filterList => _filterList;
  set filterList(List<Session> val) {
    _filterList = val;
    notifyListeners();
  }

  // List of sessions after filters are applied
  List<Session> _filteredList = [];
  List<Session> get filteredList => _filteredList;
  set filteredList(List<Session> val) {
    _filteredList = val;
    notifyListeners();
  }

  // Apply selected filters and update the filtered session list
  void sortAndFilter(BuildContext context) {
    List<Session> previousFilteredList = List.from(filteredList);

    filteredList = filterList.where((item) {
      final locationFilter = selectedLocationList.isEmpty || selectedLocationList.any((e) => e.name == item.city);

      final trainingFilter = selectedTrainingList.isEmpty || selectedTrainingList.any((e) => e.name == item.training);

      final trainersFilter = selectedTrainersList.isEmpty || selectedTrainersList.any((e) => e.name == item.trainer.name);

      return locationFilter && trainingFilter && trainersFilter;
    }).toList();

    if (!areListsEqual(previousFilteredList, filteredList)) {
      TrainingProvider trainingProvider = Provider.of(context, listen: false);

      trainingProvider.initializeSessionPaginatedList(sessions: filteredList, isRefreshed: true);
    }
  }

  // Clear all selected filters and reset the session list
  void clearFilters(context) {
    List<Session> previousFilteredList = List.from(filteredList);
    selectedLocationList.clear();
    selectedTrainingList.clear();
    selectedTrainersList.clear();
    filteredList = List.from(filterList);
    if (!areListsEqual(previousFilteredList, filteredList)) {
      TrainingProvider trainingProvider = Provider.of(context, listen: false);

      trainingProvider.initializeSessionPaginatedList(sessions: filteredList, isRefreshed: true);
    }
    notifyListeners();
  }

  // Compare two lists of sessions for equality
  bool areListsEqual(List<Session> list1, List<Session> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}
