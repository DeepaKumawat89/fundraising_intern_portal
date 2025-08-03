import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/mock_data_service.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc() : super(const LeaderboardInitial()) {
    on<LeaderboardLoadRequested>(_onLoadRequested);
    on<LeaderboardRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onLoadRequested(
    LeaderboardLoadRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(const LeaderboardLoading());

    try {
      final entries = await MockDataService.fetchLeaderboard();
      emit(LeaderboardLoaded(entries: entries));
    } catch (e) {
      emit(
        LeaderboardError(
          message: 'Failed to load leaderboard: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    LeaderboardRefreshRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    if (state is LeaderboardLoaded) {
      final currentState = state as LeaderboardLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final entries = await MockDataService.fetchLeaderboard();
        emit(LeaderboardLoaded(entries: entries, isRefreshing: false));
      } catch (e) {
        emit(
          LeaderboardError(
            message: 'Failed to refresh leaderboard: ${e.toString()}',
          ),
        );
      }
    } else {
      add(const LeaderboardLoadRequested());
    }
  }
}
