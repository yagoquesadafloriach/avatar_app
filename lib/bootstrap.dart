import 'dart:async';
import 'dart:developer';

import 'package:avatars_app/avatar_generator/data/replicate_api_repository.dart';
import 'package:avatars_app/avatar_generator/data/replicate_api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

typedef AppBuilder = FutureOr<Widget> Function(
  ReplicateApiRepository replicateApiRepository,
);

Future<void> bootstrap({required AppBuilder builder}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final replicateApiService = ReplicateApiService();
  final replicateApiRepository = ReplicateApiRepository(replicateApiService);

  // Add cross-flavor configuration here

  runApp(
    await builder(
      replicateApiRepository,
    ),
  );
}
