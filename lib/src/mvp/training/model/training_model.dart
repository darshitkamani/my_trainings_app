// To parse this JSON data, do
//
//     final trainingModel = trainingModelFromJson(jsonString);

import 'dart:convert';

import 'package:my_trainings_app/src/mvp/filter/model/filter_model.dart';

TrainingModel trainingModelFromJson(String str) =>
    TrainingModel.fromJson(json.decode(str));

String trainingModelToJson(TrainingModel data) => json.encode(data.toJson());

class TrainingModel {
  final List<Session> sessions;

  TrainingModel({
    required this.sessions,
  });

  TrainingModel copyWith({
    List<Session>? sessions,
  }) =>
      TrainingModel(
        sessions: sessions ?? this.sessions,
      );

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class Session {
  final int id;
  final Trainer trainer;
  final String training;
  final String city;
  final String place;
  final DateTime fromDate;
  final DateTime toDate;
  final String fromTime;
  final String toTime;
  final String actualFees;
  final String discountedFees;
  final String sessionName;
  final String shortDescription;
  final double ratings;
  final int totalReviews;
  final int students;
  final String createdBy;
  final List<String> language;
  final List<String> subtitles;
  final List<String> learningKeyPoints;
  final String description;

  Session({
    required this.id,
    required this.trainer,
    required this.training,
    required this.city,
    required this.place,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.actualFees,
    required this.discountedFees,
    required this.sessionName,
    required this.shortDescription,
    required this.ratings,
    required this.totalReviews,
    required this.students,
    required this.createdBy,
    required this.language,
    required this.subtitles,
    required this.learningKeyPoints,
    required this.description,
  });

  Session copyWith({
    int? id,
    Trainer? trainer,
    String? training,
    String? city,
    String? place,
    DateTime? fromDate,
    DateTime? toDate,
    String? fromTime,
    String? toTime,
    String? actualFees,
    String? discountedFees,
    String? sessionName,
    String? shortDescription,
    double? ratings,
    int? totalReviews,
    int? students,
    String? createdBy,
    List<String>? language,
    List<String>? subtitles,
    List<String>? learningKeyPoints,
    String? description,
  }) =>
      Session(
        id: id ?? this.id,
        trainer: trainer ?? this.trainer,
        training: training ?? this.training,
        city: city ?? this.city,
        place: place ?? this.place,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        fromTime: fromTime ?? this.fromTime,
        toTime: toTime ?? this.toTime,
        actualFees: actualFees ?? this.actualFees,
        discountedFees: discountedFees ?? this.discountedFees,
        sessionName: sessionName ?? this.sessionName,
        shortDescription: shortDescription ?? this.shortDescription,
        ratings: ratings ?? this.ratings,
        totalReviews: totalReviews ?? this.totalReviews,
        students: students ?? this.students,
        createdBy: createdBy ?? this.createdBy,
        language: language ?? this.language,
        subtitles: subtitles ?? this.subtitles,
        learningKeyPoints: learningKeyPoints ?? this.learningKeyPoints,
        description: description ?? this.description,
      );

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        trainer: Trainer.fromJson(json["trainer"]),
        training: json["training"],
        city: json["city"],
        place: json["place"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        fromTime: json["from_time"],
        toTime: json["to_time"],
        actualFees: json["actual_fees"],
        discountedFees: json["discounted_fees"],
        sessionName: json["session_name"],
        shortDescription: json["short_description"],
        ratings: json["ratings"]?.toDouble(),
        totalReviews: json["total_reviews"],
        students: json["students"],
        createdBy: json["created_by"],
        language: List<String>.from(json["language"].map((x) => x)),
        subtitles: List<String>.from(json["subtitles"].map((x) => x)),
        learningKeyPoints:
            List<String>.from(json["learning_key_points"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trainer": trainer.toJson(),
        "training": training,
        "city": city,
        "place": place,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "from_time": fromTime,
        "to_time": toTime,
        "actual_fees": actualFees,
        "discounted_fees": discountedFees,
        "session_name": sessionName,
        "short_description": shortDescription,
        "ratings": ratings,
        "total_reviews": totalReviews,
        "students": students,
        "created_by": createdBy,
        "language": List<dynamic>.from(language.map((x) => x)),
        "subtitles": List<dynamic>.from(subtitles.map((x) => x)),
        "learning_key_points":
            List<dynamic>.from(learningKeyPoints.map((x) => x)),
        "description": description,
      };

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
