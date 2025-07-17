import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/match_cubit.dart';
import '../cubit/match_state.dart';

class TeamMatchesScreen extends StatelessWidget {
  final String team;

  const TeamMatchesScreen({required this.team, super.key});

  Color getCardColor(
    String team,
    String team1,
    String team2,
    int? score1,
    int? score2,
  ) {
    if (score1 == null || score2 == null) return Colors.grey[300]!;

    if (score1 == score2) return Colors.grey[300]!;

    final isTeam1 = team == team1;
    final isTeam2 = team == team2;

    final didWin = (isTeam1 && score1 > score2) || (isTeam2 && score2 > score1);
    final didLose =
        (isTeam1 && score1 < score2) || (isTeam2 && score2 < score1);

    if (didWin) return Colors.green[200]!;
    if (didLose) return Colors.red[200]!;

    return Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$team Matches")),
      body: BlocBuilder<MatchCubit, MatchState>(
        builder: (context, state) {
          if (state is MatchLoaded) {
            final teamMatches =
                state.matches
                    .where(
                      (match) => match.team1 == team || match.team2 == team,
                    )
                    .toList();

            if (teamMatches.isEmpty) {
              return const Center(
                child: Text("No matches found for this team."),
              );
            }

            return ListView.builder(
              itemCount: teamMatches.length,
              itemBuilder: (context, index) {
                final match = teamMatches[index];

                final cardColor = getCardColor(
                  team,
                  match.team1,
                  match.team2,
                  match.score1,
                  match.score2,
                );

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${match.team1} vs ${match.team2}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Date: ${match.date}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Result: ${match.score1 != null && match.score2 != null ? '${match.score1} - ${match.score2}' : 'Not Played Yet'}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is MatchError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
