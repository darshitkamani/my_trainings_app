part of '../theme.dart';

/// This is the class contains all the colors of the light theme.
/// when user select the light mode in the application then we use light colors.
class LightTheme extends ThemeBase {
  /// This is the constructor of the light_theme to assign light colors.
  /// all the colors for light mode are defined in the constructor.
  LightTheme()
      : super(
          whiteColor: const Color(0xFFFFFFFF),
          blackColor: const Color(0XFF000000),
          primaryColor: const Color(0XFFFF4855),
          offWhiteColor: const Color(0XFFF2F2F2),
          greyColor: Colors.grey,
          silverColor: const Color(0XFFCCCCCC),
        );
}
