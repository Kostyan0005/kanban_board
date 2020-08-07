import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kanban_board/constants.dart';

class Board {
  String _token;
  List currentCards;

  void setToken(String token) {
    _token = token;
  }

  Future<void> getCardsForTab(int index) async {
    var response = await http.get(
      '$kApiString/cards?row=$index',
      headers: {'Authorization': 'JWT $_token'},
    );

    if (response.statusCode == 200) {
      currentCards = jsonDecode(utf8.decode(response.bodyBytes));
      currentCards.sort((c1, c2) => c1['id'].compareTo(c2['id']));
    } else {
      currentCards = null;
    }
  }
}
