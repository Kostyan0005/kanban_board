part of 'board_cubit.dart';

@immutable
abstract class BoardState {}

class BoardInitial extends BoardState {}

class TabLoaded extends BoardState {
  final int index;
  final List cards;

  TabLoaded(this.index, this.cards);
}
