part of '../theme.dart';

/// This is the class contains all the colors of the dark theme.
/// when user select the dark mode in the application then we use dark colors.
class DarkTheme extends ThemeBase {
  /// This is the constructor of the dark_theme to assign dark colors.
  /// all the colors for dark mode are defined in the constructor.
  DarkTheme()
      : super(
          whiteColor: const Color(0xFFFFFFFF),
          blackColor: const Color(0XFF000000),
          primaryColor: const Color(0XFFFF4855),
          offWhiteColor: const Color(0XFFF2F2F2),
          greyColor: const Color(0xFF9E9E9E),
          silverColor: const Color(0XFFCCCCCC),
        );
}
