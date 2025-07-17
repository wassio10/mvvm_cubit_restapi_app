import 'package:flutter_bloc/flutter_bloc.dart';
import 'match_state.dart';
import '../api/match_api.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchInitial());

  void loadMatches() async {
    emit(MatchLoading());
    try {
      final matches = await MatchApi.fetchMatches();
      emit(MatchLoaded(matches));
    } catch (e) {
      emit(MatchError(e.toString()));
    }
  }
}
