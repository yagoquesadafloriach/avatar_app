import 'package:avatars_app/avatar_generator/data/replicate_api_service.dart';

class ReplicateApiRepository {
  ReplicateApiRepository(this.apiService);
  final ReplicateApiService apiService;

  Future<dynamic> createModel({
    required String modelName,
  }) =>
      apiService.createModel(modelName: modelName);

  Future<dynamic> createTraining({
    required String destination,
    required String trainData,
  }) =>
      apiService.createTraining(
        destination: destination,
        trainData: trainData,
      );

  Future<dynamic> createPrediction({
    required String prompt,
    required String negativePrompt,
    required String image,
    required String version,
    String style = 'Photographic (Default)',
    bool isPhotoMaker = false,
  }) =>
      apiService.createPrediction(
        prompt: prompt,
        negativePrompt: negativePrompt,
        image: image,
        version: version,
        style: style,
        isPhotoMaker: isPhotoMaker,
      );

  Future<dynamic> getPrediction({
    required String predictionId,
  }) =>
      apiService.getPrediction(
        predictionId: predictionId,
      );

  Future<dynamic> getListPredictions() => apiService.getListPredictions();
}
