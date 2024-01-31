part of 'prediction_cubit.dart';

class PredictionState extends Equatable {
  const PredictionState({
    required this.status,
    required this.image,
  });

  factory PredictionState.initial() {
    return const PredictionState(
      status: FormStatus.initial,
      image: '',
    );
  }

  final FormStatus status;
  final String image;

  PredictionState copyWith({FormStatus? status, String? image}) {
    return PredictionState(
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [status, image];
}
