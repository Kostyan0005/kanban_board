import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/board_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/login/login_cubit.dart';
import 'models/login.dart';
import 'cubits/board/board_cubit.dart';
import 'models/board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginCubit(Login()),
              child: LoginScreen(),
            ),
        '/board': (context) => BlocProvider(
            create: (context) => BoardCubit(Board()),
            child: BoardScreen(context)),
      },
    );
  }
}
