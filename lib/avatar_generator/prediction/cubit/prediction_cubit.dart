// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer' as dev;

import 'package:avatars_app/avatar_generator/data/replicate_api_repository.dart';
import 'package:avatars_app/common/const/const.dart';
import 'package:avatars_app/common/const/text_consts.dart';
import 'package:avatars_app/common/enums/form_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionCubit({required this.replicateApiRepository})
      : super(
          PredictionState.initial(),
        ) {
    getPrediction();
  }

  final ReplicateApiRepository replicateApiRepository;

  Future<void> createAvatarPrediction({
    required String prompt,
    required String image,
  }) async {
    emit(state.copyWith(status: FormStatus.initial));
    try {
      emit(state.copyWith(status: FormStatus.loading));
      await replicateApiRepository.createPrediction(
        version: versionExample,
        prompt: prompt,
        negativePrompt: negativePrompt,
        image: image,
      );

      emit(state.copyWith(status: FormStatus.success));
    } catch (error) {
      dev.log('Error - $error');
      emit(state.copyWith(status: FormStatus.error));
    }
  }

  Future<void> createImagePrediction({
    required String prompt,
    required String image,
    required String style,
  }) async {
    emit(state.copyWith(status: FormStatus.initial));
    try {
      emit(state.copyWith(status: FormStatus.loading));
      await replicateApiRepository.createPrediction(
        version: versionPhotoMaker,
        prompt: prompt,
        negativePrompt: negativePrompt,
        image: image,
        style: style,
        isPhotoMaker: true,
      );

      emit(state.copyWith(status: FormStatus.success));
    } catch (error) {
      dev.log('Error - $error');
      emit(state.copyWith(status: FormStatus.error));
    }
  }

  Future<void> getPrediction() async {
    emit(state.copyWith(status: FormStatus.initial));
    try {
      emit(state.copyWith(status: FormStatus.loading));

      final prediction = await replicateApiRepository.getListPredictions();
      if (prediction == null) {
        dev.log('Error no predicion');
        emit(state.copyWith(status: FormStatus.error));
        return;
      }

      final results = (prediction as Map<String, dynamic>)['results'];
      if (results == null) {
        dev.log('Error no results');
        emit(state.copyWith(status: FormStatus.error));
        return;
      }

      final output = ((results as List<dynamic>)[0] as Map<String, dynamic>)['output'];
      if (output == null) {
        dev.log('Error no image');
        emit(state.copyWith(status: FormStatus.error));
        return;
      }

      final resp = (output as List<dynamic>)[0].toString();
      dev.log(resp);
      emit(state.copyWith(status: FormStatus.success, image: resp));
    } catch (error) {
      dev.log('Error - $error');
      emit(state.copyWith(status: FormStatus.error));
      rethrow;
    }
  }
}
