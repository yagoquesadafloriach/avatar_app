part of 'training_cubit.dart';

class TrainingState extends Equatable {
  const TrainingState({
    required this.status,
  });

  factory TrainingState.initial() {
    return const TrainingState(
      status: FormStatus.initial,
    );
  }

  final FormStatus status;

  TrainingState copyWith(FormStatus? status) {
    return TrainingState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
