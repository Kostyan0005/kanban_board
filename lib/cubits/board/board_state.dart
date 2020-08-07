part of 'board_cubit.dart';

@immutable
abstract class BoardState {}

class BoardInitial extends BoardState {}

class BoardTabLoaded extends BoardState {
  final int index;
  final List cards;

  BoardTabLoaded(this.index, this.cards);
}
