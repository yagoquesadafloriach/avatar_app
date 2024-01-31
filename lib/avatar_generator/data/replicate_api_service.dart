// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:developer';

import 'package:avatars_app/common/const/const.dart';
import 'package:http/http.dart' as http;

class ReplicateApiService {
  Future<dynamic> createModel({
    required String modelName,
  }) async {
    const apiUrl = '$baseUrl/models';

    try {
      final body = {
        'owner': owner,
        'name': modelName,
        'description': '',
        'visibility': 'private',
        // gpu-a40-large recomended if fine-tuning sdxl model
        'hardware': 'gpu-a40-large',
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to create model. Status code: ${response.statusCode}\n ${jsonDecode(response.body)}',
        );
      }
    } catch (error) {
      log('Error - $error');
    }
  }

  Future<dynamic> createTraining({
    required String destination,
    required String trainData,
  }) async {
    // using model sdxl version 39ed52f2a78e934b3ba6e2a89f5b1c712de7dfea535525255b1aa35c5565e08b
    const apiUrl = '$baseUrl/models/stability-ai/sdxl/versions/39ed52f2a78e934b3ba6e2a89f5b1c712de7dfea535525255b1aa35c5565e08b/trainings';

    try {
      final body = {
        'destination': destination,
        'input': {
          'input_images': trainData,
          'use_face_detection_instead': true,
        },
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to train model. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      log('Error - $error');
    }
  }

  Future<dynamic> createPrediction({
    required String prompt,
    required String negativePrompt,
    required String image,
    required String version,
    required String style,
    required bool isPhotoMaker,
  }) async {
    const apiUrl = '$baseUrl/predictions';

    try {
      late Map<String, Object> body;

      if (isPhotoMaker) {
        body = {
          'version': version,
          'input': {
            'prompt': prompt,
            'negative_prompt': negativePrompt,
            'input_image': image,
            'style_name': style,
            'num_steps': 40,
            'guidance_scale': 7.0,
            'style_strength_ratio': 20,
          },
        };
      } else {
        body = {
          'version': version,
          'input': {
            'prompt': prompt,
            'negative_prompt': negativePrompt,
            'image': image,
            'width': 1024,
            'height': 1024,
            'num_outputs': 1,
            'num_interference_steps': 40,
            'guidance_scale': 7,
            'prompt_strength': 0.28,
            // 'refine': 'expert_ensemble_refiner',
            // 'high_noise_frac': 0.99,
            'apply_watermark': true,
            'lora_scale': 0.9,
          },
        };
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to run model. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      log('Error - $error');
    }
  }

  Future<dynamic> getPrediction({
    required String predictionId,
  }) async {
    final apiUrl = '$baseUrl/predictions/$predictionId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $apiToken'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to get prediction. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      log('Error - $error');
      rethrow;
    }
  }

  Future<dynamic> getListPredictions() async {
    const apiUrl = '$baseUrl/predictions';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $apiToken'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to get prediction. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      log('Error - $error');
      rethrow;
    }
  }
}
