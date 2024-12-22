import 'package:flutter/material.dart';
import 'package:my_trainings_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(
    const MyTrainingsApp(),
  );
}

///  Main application class from where the application will begin running.
class MyTrainingsApp extends StatelessWidget {
  /// Constructor of the main class.
  const MyTrainingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    VariableUtilities.theme = LightTheme();
    return MultiProvider(
      providers: ProviderBind.providers,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteUtilities.root,
          onGenerateRoute: RouteUtilities.onGenerateRoute,
          theme: ThemeData(),
        );
      },
    );
  }
}
