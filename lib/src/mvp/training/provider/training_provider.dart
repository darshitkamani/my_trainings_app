import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/utilities/asset/asset_utilities.dart';
import 'package:provider/provider.dart';

/// TrainingProvider
class TrainingProvider extends ChangeNotifier {
  List<Session> courseHighlightsList = []; // Highlighted training sessions

  // List of all training sessions
  List<Session> _sessionsList = [];
  List<Session> get sessionsList => _sessionsList;
  set sessionsList(List<Session> val) {
    _sessionsList = val;
    notifyListeners();
  }

  bool _isNextSessionLoading = false; // Flag to track loading state for pagination
  bool get isNextSessionLoading => _isNextSessionLoading;
  set isNextSessionLoading(bool val) {
    _isNextSessionLoading = val;
    notifyListeners();
  }

  // List of sessions for pagination
  List<Session> _paginatedSessionsList = [];
  List<Session> get paginatedSessionsList => _paginatedSessionsList;
  set paginatedSessionsList(List<Session> val) {
    _paginatedSessionsList = val;
    notifyListeners();
  }

  int _pageNumber = 0; // Current page number for pagination
  int get pageNumber => _pageNumber;
  set pageNumber(int val) {
    _pageNumber = val;
    notifyListeners();
  }

  // Function to get paginated sessions
  Future<List<Session>> getPaginatedSessions(int pageSize, List<Session> sessions) async {
    int totalPages = getTotalPages(pageSize); // Get the total number of pages

    // Check if we have more pages to load
    if (pageNumber >= totalPages) {
      return [];
    }

    // Calculate indices for the current page
    int startIndex = pageNumber * pageSize;
    int endIndex = startIndex + pageSize;

    if (startIndex >= sessions.length) {
      return [];
    }

    // Set loading state
    isNextSessionLoading = true;

    if (paginatedSessionsList.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    // Reset loading state
    isNextSessionLoading = false;

    // Ensure endIndex doesn't exceed the list length
    endIndex = endIndex > sessions.length ? sessions.length : endIndex;

    // Increment the page number for the next request
    pageNumber++;

    // Return the paginated sublist
    return sessions.sublist(startIndex, endIndex);
  }

  // Function to calculate the total number of pages
  int getTotalPages(int pageSize) {
    return (sessionsList.length / pageSize).ceil();
  }

  // Initialization function to load training data
  Future init(BuildContext context) async {
    TrainingModel trainingModel = await loadJsonAsset();
    sessionsList = trainingModel.sessions;
    courseHighlightsList = await getRandomSessions(sessionsList);
    if (context.mounted) {
      FilterProvider filterProvider = Provider.of(context, listen: false);
      await filterProvider.init();
      filterProvider.filterList = trainingModel.sessions;
      filterProvider.filteredList = trainingModel.sessions;
      await initializeSessionPaginatedList(sessions: filterProvider.filteredList);
    }
  }

  // Function to initialize the paginated session list
  Future<void> initializeSessionPaginatedList({required List<Session> sessions, bool isRefreshed = false}) async {
    if (isRefreshed) {
      pageNumber = 0;
      paginatedSessionsList = await getPaginatedSessions(5, sessions);
    } else {
      paginatedSessionsList.addAll(await getPaginatedSessions(5, sessions));
    }
  }

  // Function to get a random subset of sessions
  Future<List<Session>> getRandomSessions(List<Session> sessions) async {
    if (sessions.isEmpty) return [];
    final randomItems = sessionsList.toList()..shuffle();
    return randomItems.take(5).toList();
  }

  // Function to load JSON data from assets
  Future<TrainingModel> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString(AssetUtilities.trainingJson); // Load the JSON file
    TrainingModel trainingModel = TrainingModel.fromJson(jsonDecode(jsonString)); // Decode JSON to model
    return trainingModel;
  }
}
