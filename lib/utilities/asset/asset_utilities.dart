/// all the assets, images, video, audio and other files
/// used in the application.
///
/// are defined in this file.
class AssetUtilities {
  static const String _baseUrl = 'assets/';
  static const String _pngUrl = '${_baseUrl}png/';
  static const String _jsonUrl = '${_baseUrl}json/';

  static const String trainingBanner1 = '${_pngUrl}training_banner_1.png';
  static const String trainingBanner2 = '${_pngUrl}training_banner_2.png';
  static const String trainingBanner3 = '${_pngUrl}training_banner_3.png';
  static const String filterIcon = '${_pngUrl}filter_icon.png';
  static const String companyLogo = '${_pngUrl}company_logo.png';
  static const String profileIcon = '${_pngUrl}profile.png';
  static const String appLogo = '${_pngUrl}app_logo.png';

  ///Json Files
  static const String filterDataJson = '${_jsonUrl}filter_data.json';
  static const String trainingJson = '${_jsonUrl}training.json';
  static const String noDataFoundJson = '${_jsonUrl}no_data_found.json';
}
