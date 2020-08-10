import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:kanban_board/models/board.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final Board _board;

  BoardCubit(this._board) : super(BoardInitial());

  Future<void> handleTabSelection(int index) async {
    await _board.getCardsForTab(index);
    if (_board.currentCards != null) {
      emit(TabLoaded(index, _board.currentCards));
    }
  }

  void setToken(String token) {
    _board.setToken(token);
  }
}
