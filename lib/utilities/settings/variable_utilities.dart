import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

/// All the global variables used in the application are defined in this class.
class VariableUtilities {
  /// we can use screenSize in application using this global variable.
  static late Size screenSize;

  /// we can use multiple theme using this variable.
  /// we can switch between themes by assigning new theme in this class.
  /// we can access all the colors using in the application by this variable.
  static late ThemeBase theme;
}
