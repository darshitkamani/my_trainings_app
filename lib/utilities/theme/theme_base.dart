part of 'theme.dart';

/// all the colors used in the application are managed using this theme_base.
/// if you want to use the additional colors then you can add in this class.
///
abstract class ThemeBase {
  /// Constructor of the theme_base to required all the colors.
  ThemeBase({
    required this.whiteColor,
    required this.blackColor,
    required this.primaryColor,
    required this.offWhiteColor,
    required this.greyColor,
    required this.silverColor,
  });

  final Color whiteColor;
  final Color blackColor;
  final Color primaryColor;
  final Color offWhiteColor;
  final Color greyColor;
  final Color silverColor;
}
