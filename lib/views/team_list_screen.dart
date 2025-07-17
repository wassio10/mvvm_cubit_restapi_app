import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/match_cubit.dart';
import '../cubit/match_state.dart';
import 'team_matches_screen.dart';

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Team"), centerTitle: true),
      body: BlocBuilder<MatchCubit, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchLoaded) {
            final Set<String> teams = {};
            for (var match in state.matches) {
              teams.add(match.team1);
              teams.add(match.team2);
            }

            final teamList = teams.toList();
            teamList.sort();

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: teamList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        teamList[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TeamMatchesScreen(team: teamList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is MatchError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
