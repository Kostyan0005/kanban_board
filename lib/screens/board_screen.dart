import 'package:flutter/material.dart';
import 'package:kanban_board/constants.dart';
import 'package:kanban_board/widgets/board_card.dart';
import 'package:kanban_board/cubits/board/board_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardScreenArgs {
  final String token;
  BoardScreenArgs(this.token);
}

// I have to use StatefulWidget because tabController needs
// SingleTickerProviderStateMixin which can only be added to State
class BoardScreen extends StatefulWidget {
  final BuildContext context;
  BoardScreen(this.context);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  String token;
  TabController tabController;

  @override
  void initState() {
    final BoardScreenArgs args =
        ModalRoute.of(widget.context).settings.arguments;
    token = args.token;
    tabController = TabController(vsync: this, length: kTabNumber);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<BoardCubit>().setToken(token);

    void handleTabSelection() {
      context.bloc<BoardCubit>().handleTabSelection(tabController.index);
    }

    tabController.addListener(handleTabSelection);
    handleTabSelection();

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: <Widget>[
          FloatingActionButton(
            backgroundColor: kFocusedColor,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'On hold'),
            Tab(text: 'In progress'),
            Tab(text: 'Needs review'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: TabBarView(
          controller: tabController,
          children: getTabList(),
        ),
      ),
    );
  }

  List<Widget> getTabList() {
    List<Widget> tabList = [];
    for (int i = 0; i < kTabNumber; i++) {
      tabList.add(BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          if (state is BoardTabLoaded && state.index == i) {
            return buildCardListView(state.cards);
          }
          return buildProgressIndicator();
        },
      ));
    }
    return tabList;
  }

  ListView buildCardListView(List cards) {
    List<Widget> cardList = [];
    for (Map card in cards) {
      cardList.add(
        BoardCard(
          id: card['id'],
          text: card['text'],
        ),
      );
    }
    return ListView(
      children: cardList,
    );
  }

  Center buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
