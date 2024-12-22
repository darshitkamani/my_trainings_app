import 'package:my_trainings_app/src/mvp/filter/provider/filter_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_trainings_app/src/mvp/training/provider/training_provider.dart';

/// This class manage all the provider and return list of provider.
class ProviderBind {
  /// This is the list of providers to manage and attache with application.
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<TrainingProvider>(create: (_) => TrainingProvider()),
    ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
  ];
}
