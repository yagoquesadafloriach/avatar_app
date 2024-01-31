// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer' as dev;
import 'dart:math';

import 'package:avatars_app/avatar_generator/data/replicate_api_repository.dart';
import 'package:avatars_app/common/const/const.dart';
import 'package:avatars_app/common/enums/form_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit({required this.replicateApiRepository})
      : super(
          TrainingState.initial(),
        );

  final ReplicateApiRepository replicateApiRepository;

  Future<String> _createModel() async {
    emit(state.copyWith(FormStatus.initial));
    try {
      emit(state.copyWith(FormStatus.loading));

      final modelName = _randomModelName();
      await replicateApiRepository.createModel(
        modelName: modelName,
      );

      emit(state.copyWith(FormStatus.success));
      return modelName;
    } catch (error) {
      dev.log('Error - $error');
      emit(state.copyWith(FormStatus.error));
      rethrow;
    }
  }

  String _randomModelName() {
    final now = DateTime.now();
    final timestamp = now.microsecondsSinceEpoch;

    final random = Random();
    final randomIdentifier = random.nextInt(999999);

    final uniqueName = 'unique_name_$timestamp$randomIdentifier';

    final correct = uniqueName.replaceAll(RegExp('[^a-z0-9._-]'), '_');

    final trimmed = correct.replaceAll(RegExp(r'^[._-]+|[._-]+$'), '');

    return trimmed;
  }

  Future<void> createTraining() async {
    emit(state.copyWith(FormStatus.initial));
    try {
      emit(state.copyWith(FormStatus.loading));

      final modelName = await _createModel();

      await replicateApiRepository.createTraining(
        destination: '$owner/$modelName',
        trainData: trainDataExample,
      );
      emit(state.copyWith(FormStatus.success));
    } catch (error) {
      dev.log('Errors - $error');
      emit(state.copyWith(FormStatus.error));
    }
  }
}
