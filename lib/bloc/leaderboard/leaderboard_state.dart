import 'package:equatable/equatable.dart';
import '../../models/leaderboard_entry.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> entries;
  final bool isRefreshing;

  const LeaderboardLoaded({required this.entries, this.isRefreshing = false});

  @override
  List<Object?> get props => [entries, isRefreshing];

  LeaderboardLoaded copyWith({
    List<LeaderboardEntry>? entries,
    bool? isRefreshing,
  }) {
    return LeaderboardLoaded(
      entries: entries ?? this.entries,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  List<LeaderboardEntry> get topThree => entries.take(3).toList();
  List<LeaderboardEntry> get remaining => entries.skip(3).toList();
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
