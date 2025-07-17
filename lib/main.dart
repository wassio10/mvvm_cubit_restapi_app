import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/match_cubit.dart';
import 'views/team_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchCubit()..loadMatches(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Football Matches',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TeamListScreen(),
      ),
    );
  }
}
