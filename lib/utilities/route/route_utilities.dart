import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/mvp/filter/view/filter_screen.dart';
import 'package:my_trainings_app/src/mvp/splash/view/splash_screen.dart';
import 'package:my_trainings_app/src/mvp/training/model/training_model.dart';
import 'package:my_trainings_app/src/mvp/training/view/training_details_view.dart';
import 'package:my_trainings_app/src/mvp/training/view/training_screen.dart';

/// Manage all the routes used in the application.
class RouteUtilities {
  /// first screen to open in the application.
  static const String root = '/';

  /// splash screen.
  static const String splashScreen = '/splashScreen';

  /// Training Screen.
  static const String trainingScreen = '/trainingScreen';

  /// Training Details Screen.
  static const String trainingDetailsScreen = '/trainingDetailsScreen';

  /// Filter Details Screen.
  static const String filterScreen = '/filterScreen';

  /// we are using named route to navigate to another screen,
  /// and while redirecting to the next screen we are using this function
  /// to pass arguments and other routing things..
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteUtilities.root;

    /// this is the instance of arguments to pass data in other screens.
    // dynamic arguments = settings.arguments;
    switch (routeName) {
      case RouteUtilities.root:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RouteUtilities.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RouteUtilities.trainingScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TrainingScreen(),
        );
      case RouteUtilities.trainingDetailsScreen:
        var session = (settings.arguments is Session)
            ? settings.arguments as Session
            : null;
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              TrainingDetailsView(session: session as Session),
        );

      case RouteUtilities.filterScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FilterScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
    }
  }
}
