part of 'honest_truth_cubit.dart';

sealed class HonestTruthState extends Equatable {
  const HonestTruthState();

  @override
  List<Object> get props => [];
}

final class HonestTruthInitial extends HonestTruthState {}
class HonestTruthLoading extends HonestTruthState {}
class HonestTruthLoaded extends HonestTruthState {
  final HonestTruthEntity entity;
  const HonestTruthLoaded(this.entity);
    @override
  List<Object> get props => [entity];
}
class HonestTruthError extends HonestTruthState {
  final String message;
  const HonestTruthError(this.message);
    @override
  List<Object> get props => [message];
}