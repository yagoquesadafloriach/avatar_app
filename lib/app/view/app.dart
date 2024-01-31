import 'package:avatars_app/avatar_generator/data/replicate_api_repository.dart';
import 'package:avatars_app/avatar_generator/prediction/cubit/prediction_cubit.dart';
import 'package:avatars_app/avatar_generator/training/cubit/training_cubit.dart';
import 'package:avatars_app/home/view/home_page.dart';
import 'package:avatars_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.replicateApiRepository,
    super.key,
  });

  final ReplicateApiRepository replicateApiRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => replicateApiRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TrainingCubit(
              replicateApiRepository: replicateApiRepository,
            ),
          ),
          BlocProvider(
            create: (_) => PredictionCubit(
              replicateApiRepository: replicateApiRepository,
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
        ),
      ),
    );
  }
}
