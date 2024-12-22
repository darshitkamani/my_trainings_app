import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  final List<Trainer> trainers;
  final List<BaseModel> trainings;
  final List<BaseModel> locations;

  FilterModel({
    required this.trainers,
    required this.trainings,
    required this.locations,
  });

  FilterModel copyWith({
    List<Trainer>? trainers,
    List<BaseModel>? trainings,
    List<BaseModel>? locations,
  }) =>
      FilterModel(
        trainers: trainers ?? this.trainers,
        trainings: trainings ?? this.trainings,
        locations: locations ?? this.locations,
      );

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        trainers: List<Trainer>.from(json["trainers"].map((x) => Trainer.fromJson(x))),
        trainings: List<BaseModel>.from(json["trainings"].map((x) => BaseModel.fromJson(x))),
        locations: List<BaseModel>.from(json["locations"].map((x) => BaseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trainers": List<dynamic>.from(trainers.map((x) => x.toJson())),
        "trainings": List<dynamic>.from(trainings.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class BaseModel {
  final int id;
  final String name;

  BaseModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  BaseModel copyWith({
    int? id,
    String? name,
  }) =>
      BaseModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Trainer {
  final int id;
  final String name;
  final String skill;
  final String avatar;
  final String badge;
  final String badgeIcon;

  Trainer({
    required this.id,
    required this.name,
    required this.skill,
    required this.avatar,
    required this.badge,
    required this.badgeIcon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Trainer && other.name == name && other.skill == skill && other.avatar == avatar && other.badge == badge && other.badgeIcon == badgeIcon;
  }

  @override
  int get hashCode => name.hashCode ^ skill.hashCode ^ avatar.hashCode ^ badge.hashCode ^ badgeIcon.hashCode;

  Trainer copyWith({
    int? id,
    String? name,
    String? skill,
    String? avatar,
    String? badge,
    String? badgeIcon,
  }) =>
      Trainer(
        id: id ?? this.id,
        name: name ?? this.name,
        skill: skill ?? this.skill,
        avatar: avatar ?? this.avatar,
        badge: badge ?? this.badge,
        badgeIcon: badgeIcon ?? this.badgeIcon,
      );

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"] ?? 0, // id is not needed for equality check
        name: json["name"],
        skill: json["skill"],
        avatar: json["avatar"],
        badge: json["badge"],
        badgeIcon: json["badge_icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "skill": skill,
        "avatar": avatar,
        "badge": badge,
        "badge_icon": badgeIcon,
      };
}
