class MatchModel {
  final String date;
  final String team1;
  final String team2;
  final int? score1;
  final int? score2;

  MatchModel({
    required this.date,
    required this.team1,
    required this.team2,
    this.score1,
    this.score2,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? ftScore = json['score']?['ft'];
    int? score1;
    int? score2;

    if (ftScore != null && ftScore.length == 2) {
      score1 = ftScore[0];
      score2 = ftScore[1];
    }

    return MatchModel(
      date: json['date'],
      team1: json['team1'],
      team2: json['team2'],
      score1: score1,
      score2: score2,
    );
  }
}
