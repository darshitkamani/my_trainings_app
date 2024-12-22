import 'package:flutter/material.dart';

class TrainingFilterModel {
  final String name;
  final IconData icon;

  TrainingFilterModel({required this.name, required this.icon});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrainingFilterModel) return false;

    return name == other.name && icon == other.icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}
